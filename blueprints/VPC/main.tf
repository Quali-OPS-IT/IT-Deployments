resource "aws_vpc" "quali_it_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = var.tags
}

resource "aws_subnet" "app_subnet" {
  vpc_id                  = aws_vpc.quali_it_vpc.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = true

  tags = var.tags
}

resource "aws_security_group" "default_sg" {
  vpc_id = aws_vpc.quali_it_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
