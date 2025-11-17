resource "aws_vpc" "it_deployments" {
  tags = {
    Name = "IT-Deployments"
  }
  tags_all = {
    Name = "IT-Deployments"
  }
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  provider = aws.eu_west_1
}