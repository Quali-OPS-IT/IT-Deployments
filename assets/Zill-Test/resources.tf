resource "aws_instance" "instance_bpvsymm4" {
  provider = aws.eu_west_1
  ami = "ami-08b6a2983df6e9e25"
  associate_public_ip_address = true
  availability_zone = "eu-west-1a"
  disable_api_stop = false
  disable_api_termination = false
  ebs_optimized = false
  get_password_data = false
  hibernation = false
  host_id = null
  host_resource_group_arn = null
  iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"
  instance_initiated_shutdown_behavior = "stop"
  instance_type = "t2.small"
  key_name = "IT-Deployments-Key-Pair"
  monitoring = false
  placement_group = null
  placement_partition_number = 0
  private_ip = "172.31.3.240"
  secondary_private_ips = [
  ]
  security_groups = [
    "launch-wizard-1"
  ]
  source_dest_check = true
  subnet_id = "subnet-09f99c073759155b0"
  tags = {
    Name = "Test3"
  }
  tags_all = {
    Name = "Test3"
  }
  tenancy = "default"
  user_data = null
  user_data_base64 = null
  user_data_replace_on_change = null
  volume_tags = null
  vpc_security_group_ids = [
    "sg-0b685fd47392e6df4"
  ]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp = null
    core_count = 1
    threads_per_core = 1
  }
  credit_specification {
    cpu_credits = "standard"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint = "enabled"
    http_put_response_hop_limit = 2
    http_tokens = "required"
    instance_metadata_tags = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted = false
    iops = 3000
    kms_key_id = null
    tags = {

    }
    throughput = 125
    volume_size = 8
    volume_type = "gp3"
  }
}
resource "aws_instance" "instance_qcmrdeer" {
  provider = aws.eu_west_1
  ami = "ami-08b6a2983df6e9e25"
  associate_public_ip_address = true
  availability_zone = "eu-west-1a"
  disable_api_stop = false
  disable_api_termination = false
  ebs_optimized = false
  get_password_data = false
  hibernation = false
  host_id = null
  host_resource_group_arn = null
  iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"
  instance_initiated_shutdown_behavior = "stop"
  instance_type = "t2.small"
  key_name = "IT-Deployments-Key-Pair"
  monitoring = false
  placement_group = null
  placement_partition_number = 0
  private_ip = "172.31.15.32"
  secondary_private_ips = [
  ]
  security_groups = [
    "launch-wizard-1"
  ]
  source_dest_check = true
  subnet_id = "subnet-09f99c073759155b0"
  tags = {
    Name = "Test3"
  }
  tags_all = {
    Name = "Test3"
  }
  tenancy = "default"
  user_data = null
  user_data_base64 = null
  user_data_replace_on_change = null
  volume_tags = null
  vpc_security_group_ids = [
    "sg-0b685fd47392e6df4"
  ]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp = null
    core_count = 1
    threads_per_core = 1
  }
  credit_specification {
    cpu_credits = "standard"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint = "enabled"
    http_put_response_hop_limit = 2
    http_tokens = "required"
    instance_metadata_tags = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted = false
    iops = 3000
    kms_key_id = null
    tags = {

    }
    throughput = 125
    volume_size = 8
    volume_type = "gp3"
  }
}

resource "aws_instance" "instance_a6bpod5d" {
  provider = aws.eu_west_1
  ami = "ami-08b6a2983df6e9e25"
  associate_public_ip_address = true
  availability_zone = "eu-west-1c"
  disable_api_stop = false
  disable_api_termination = false
  ebs_optimized = false
  get_password_data = false
  hibernation = false
  host_id = null
  host_resource_group_arn = null
  iam_instance_profile = "AmazonSSMRoleForInstancesQuickSetup"
  instance_initiated_shutdown_behavior = "stop"
  instance_type = "t2.medium"
  key_name = "IT-Deployments-Key-Pair"
  monitoring = false
  placement_group = null
  placement_partition_number = 0
  private_ip = "172.31.34.150"
  secondary_private_ips = [
  ]
  security_groups = [
    "launch-wizard-1"
  ]
  source_dest_check = true
  subnet_id = "subnet-000cfb057abcae10a"
  tags = {
    Name = "Test4"
  }
  tags_all = {
    Name = "Test4"
  }
  tenancy = "default"
  user_data = null
  user_data_base64 = null
  user_data_replace_on_change = null
  volume_tags = null
  vpc_security_group_ids = [
    "sg-0b685fd47392e6df4"
  ]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    amd_sev_snp = null
    core_count = 2
    threads_per_core = 1
  }
  credit_specification {
    cpu_credits = "standard"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint = "enabled"
    http_put_response_hop_limit = 2
    http_tokens = "required"
    instance_metadata_tags = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record = true
    enable_resource_name_dns_aaaa_record = false
    hostname_type = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted = false
    iops = 100
    kms_key_id = null
    tags = {

    }
    throughput = 0
    volume_size = 8
    volume_type = "gp3"
  }
}
import {
  to = aws_instance.instance_a6bpod5d
  id = "i-029d1e3a25a681456"
}
