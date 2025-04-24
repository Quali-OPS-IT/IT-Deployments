resource "aws_internet_gateway" "project_igw" {
  tags = {
    Name = "project-igw"
  }
  tags_all = {
    Name = "project-igw"
  }
  vpc_id   = aws_vpc.project_vpc.id
  provider = aws.eu_west_1
}
resource "aws_route_table" "project_rtb_private1_eu_west_1a" {
  tags = {
    Name = "project-rtb-private1-eu-west-1a"
  }
  tags_all = {
    Name = "project-rtb-private1-eu-west-1a"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "nat-01df195ddde545698"
  }
  vpc_id   = aws_vpc.project_vpc.id
  provider = aws.eu_west_1
}
resource "aws_route_table" "project_rtb_private2_eu_west_1b" {
  tags = {
    Name = "project-rtb-private2-eu-west-1b"
  }
  tags_all = {
    Name = "project-rtb-private2-eu-west-1b"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "nat-01df195ddde545698"
  }
  vpc_id   = aws_vpc.project_vpc.id
  provider = aws.eu_west_1
}
resource "aws_route_table" "project_rtb_public" {
  tags = {
    Name = "project-rtb-public"
  }
  tags_all = {
    Name = "project-rtb-public"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_igw.id
  }
  vpc_id   = aws_vpc.project_vpc.id
  provider = aws.eu_west_1
}
resource "aws_subnet" "project_subnet_private1_eu_west_1a" {
  tags = {
    Name = "project-subnet-private1-eu-west-1a"
  }
  tags_all = {
    Name = "project-subnet-private1-eu-west-1a"
  }
  availability_zone_id                = "euw1-az1"
  cidr_block                          = "10.0.128.0/20"
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.project_vpc.id
  provider                            = aws.eu_west_1
}
resource "aws_subnet" "project_subnet_private2_eu_west_1b" {
  tags = {
    Name = "project-subnet-private2-eu-west-1b"
  }
  tags_all = {
    Name = "project-subnet-private2-eu-west-1b"
  }
  availability_zone                   = "eu-west-1b"
  cidr_block                          = "10.0.144.0/20"
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.project_vpc.id
  provider                            = aws.eu_west_1
}
resource "aws_subnet" "project_subnet_public1_eu_west_1a" {
  tags = {
    Name = "project-subnet-public1-eu-west-1a"
  }
  tags_all = {
    Name = "project-subnet-public1-eu-west-1a"
  }
  availability_zone                   = "eu-west-1a"
  cidr_block                          = "10.0.0.0/20"
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.project_vpc.id
  provider                            = aws.eu_west_1
}
resource "aws_subnet" "project_subnet_public2_eu_west_1b" {
  tags = {
    Name = "project-subnet-public2-eu-west-1b"
  }
  tags_all = {
    Name = "project-subnet-public2-eu-west-1b"
  }
  availability_zone                   = "eu-west-1b"
  cidr_block                          = "10.0.16.0/20"
  private_dns_hostname_type_on_launch = "ip-name"
  vpc_id                              = aws_vpc.project_vpc.id
  provider                            = aws.eu_west_1
}
resource "aws_vpc" "project_vpc" {
  tags = {
    Name = "project-vpc"
  }
  tags_all = {
    Name = "project-vpc"
  }
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  provider             = aws.eu_west_1
}
