resource "aws_vpc" "quali_it_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = var.tags
}

resource "aws_subnet" "app_subnet" {
  count = length(var.subnet_cidr)

  vpc_id                  = aws_vpc.quali_it_vpc.id
  cidr_block              = element(var.subnet_cidr, count.index)
  availability_zone       = element(var.az, count.index)
  map_public_ip_on_launch = true

  tags = var.tags
}

resource "aws_security_group" "default_sg" {
  vpc_id = aws_vpc.quali_it_vpc.id

  dynamic "ingress" {
    for_each = var.security_group_ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
