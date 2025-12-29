provider "aws" {
  region = var.region
}

data "aws_subnet" "selected" {
  id = var.subnet_id
}

locals {
  # --- SSM-backed choices (AWS-maintained) ---
  use_ssm = contains([
    "amazonlinux2",
    "amazonlinux2023",
    "windows2019full",
    "windows2022full",
    "windows2022core"
  ], var.os_image)

  # Amazon Linux SSM parameters (public, region-specific values)
  al2_ssm_param = (
    var.architecture == "arm64"
    ? "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-arm64-gp2"
    : "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
  )

  al2023_ssm_param = (
    var.architecture == "arm64"
    ? "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-arm64"
    : "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  )

  windows_ssm_param = (
    var.os_image == "windows2019full" ? "/aws/service/ami-windows-latest/Windows_Server-2019-English-Full-Base" :
    var.os_image == "windows2022full" ? "/aws/service/ami-windows-latest/Windows_Server-2022-English-Full-Base" :
    var.os_image == "windows2022core" ? "/aws/service/ami-windows-latest/Windows_Server-2022-English-Core-Base" :
    null
  )

  # THIS was missing in your screenshot (caused local.ssm_param_name error)
  ssm_param_name = (
    var.os_image == "amazonlinux2" ? local.al2_ssm_param :
    var.os_image == "amazonlinux2023" ? local.al2023_ssm_param :
    local.windows_ssm_param
  )

  # --- AMI lookup choices (publisher-owned) ---
  # NOTE: Owner IDs assume standard AWS partition (not GovCloud/China).
  ubuntu_owner = "099720109477" # Canonical
  debian_owner = "136693071363" # Debian Cloud Team

  ubuntu_name = (
    var.os_image == "ubuntu2004" ? "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-%s-server-*" :
    var.os_image == "ubuntu2204" ? "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-%s-server-*" :
    var.os_image == "ubuntu2404" ? "ubuntu/images/hvm-ssd/ubuntu-noble-24.04-%s-server-*" :
    null
  )
  ubuntu_arch_tag = var.architecture == "arm64" ? "arm64" : "amd64"

  debian_name = (
    var.os_image == "debian11" ? "debian-11-%s-*" :
    var.os_image == "debian12" ? "debian-12-%s-*" :
    null
  )
  debian_arch_tag = var.architecture == "arm64" ? "arm64" : "amd64"
}

data "aws_ssm_parameter" "selected_ami" {
  count = local.use_ssm ? 1 : 0
  name  = local.ssm_param_name
}

data "aws_ami" "selected_ami" {
  count       = local.use_ssm ? 0 : 1
  most_recent = true

  owners = (
    startswith(var.os_image, "ubuntu") ? [local.ubuntu_owner] :
    startswith(var.os_image, "debian") ? [local.debian_owner] :
    []
  )

  filter {
    name = "name"
    values = [
      startswith(var.os_image, "ubuntu") ? format(local.ubuntu_name, local.ubuntu_arch_tag) :
      startswith(var.os_image, "debian") ? format(local.debian_name, local.debian_arch_tag) :
      "INVALID"
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

locals {
  ssm_ami_id    = try(data.aws_ssm_parameter.selected_ami[0].value, null)
  lookup_ami_id = try(data.aws_ami.selected_ami[0].id, null)
  ami_id        = coalesce(local.ssm_ami_id, local.lookup_ami_id)

  vpc_id = data.aws_subnet.selected.vpc_id

  created_sg_ids = var.create_security_group ? [aws_security_group.ec2[0].id] : []
  all_sg_ids     = concat(local.created_sg_ids, var.security_group_ids)
}

resource "aws_security_group" "ec2" {
  count       = var.create_security_group ? 1 : 0
  name_prefix = "ec2-curated-"
  description = "Security group for curated EC2 module"
  vpc_id      = local.vpc_id

  tags = merge(var.tags, {
    "Name" = "ec2-curated-sg"
  })
}

resource "aws_security_group_rule" "inbound" {
  for_each = (
    var.create_security_group && length(var.inbound_ports) > 0
    ? { for p in var.inbound_ports : tostring(p) => p }
    : {}
  )

  type              = "ingress"
  security_group_id = aws_security_group.ec2[0].id
  protocol          = "tcp"
  from_port         = each.value
  to_port           = each.value
  cidr_blocks       = var.allowed_cidrs
  description       = "Inbound port ${each.value}"
}

resource "aws_security_group_rule" "egress_all" {
  count             = var.create_security_group ? 1 : 0
  type              = "egress"
  security_group_id = aws_security_group.ec2[0].id
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound"
}

resource "aws_instance" "this" {
  ami                         = local.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = local.all_sg_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = var.user_data

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = var.root_volume_type
    encrypted   = var.root_volume_encrypted
  }

  tags = merge(var.tags, {
    "Name" = "ec2-curated"
  })

  lifecycle {
    precondition {
      condition     = local.ami_id != null
      error_message = "AMI could not be resolved for os_image=${var.os_image} architecture=${var.architecture}."
    }

    precondition {
      condition     = !(startswith(var.os_image, "windows") && var.architecture == "arm64")
      error_message = "Windows curated images in this module only support x86_64."
    }

    precondition {
      condition     = (var.create_security_group || length(var.security_group_ids) > 0)
      error_message = "Either set create_security_group=true or provide at least one security_group_ids."
    }

    precondition {
      condition     = (length(var.inbound_ports) == 0) || (length(var.allowed_cidrs) > 0)
      error_message = "If inbound_ports is set, allowed_cidrs must be non-empty."
    }
  }
}
