resource "aws_instance" "instance_kcxgxhqb" {
  provider = aws.eu_west_1
  ami = "ami-09c54d172e7aa3d9a"
  associate_public_ip_address = true
  availability_zone = "eu-west-1a"
  disable_api_stop = false
  disable_api_termination = false
  ebs_optimized = false
  get_password_data = false
  hibernation = false
  host_id = null
  host_resource_group_arn = null
  iam_instance_profile = null
  instance_initiated_shutdown_behavior = "stop"
  instance_type = "t2.small"
  key_name = "IT-Deployments-Key-Pair"
  monitoring = false
  placement_group = null
  placement_partition_number = 0
  private_ip = "172.31.3.196"
  secondary_private_ips = [
  ]
  security_groups = [
    "default"
  ]
  source_dest_check = true
  subnet_id = "subnet-09f99c073759155b0"
  tags = {
    Name = "VM21"
  }
  tags_all = {
    Name = "VM21"
  }
  tenancy = "default"
  user_data = null
  user_data_base64 = null
  user_data_replace_on_change = null
  volume_tags = null
  vpc_security_group_ids = [
    "sg-004bf30c0011fa2f2"
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
resource "aws_instance" "instance_b1ssl9vf" {
  provider = aws.eu_west_1
  ami = "ami-09c54d172e7aa3d9a"
  associate_public_ip_address = true
  availability_zone = "eu-west-1a"
  disable_api_stop = false
  disable_api_termination = false
  ebs_optimized = false
  get_password_data = false
  hibernation = false
  host_id = null
  host_resource_group_arn = null
  iam_instance_profile = null
  instance_initiated_shutdown_behavior = "stop"
  instance_type = "t2.small"
  key_name = "IT-Deployments-Key-Pair"
  monitoring = false
  placement_group = null
  placement_partition_number = 0
  private_ip = "172.31.14.133"
  secondary_private_ips = [
  ]
  security_groups = [
    "default"
  ]
  source_dest_check = true
  subnet_id = "subnet-09f99c073759155b0"
  tags = {
    Name = "VM21"
  }
  tags_all = {
    Name = "VM21"
  }
  tenancy = "default"
  user_data = null
  user_data_base64 = null
  user_data_replace_on_change = null
  volume_tags = null
  vpc_security_group_ids = [
    "sg-004bf30c0011fa2f2"
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
