provider "aws" {
  region = "eu-west-1" # Adjust as needed
}

# VPC Setup
resource "aws_vpc" "tf_learning_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Terraform-Learning-VPC"
  }
}

# Subnet
resource "aws_subnet" "tf_learning_subnet" {
  vpc_id                  = aws_vpc.tf_learning_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "eu-west-1a"

  tags = {
    Name = "Terraform-Learning-Subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "tf_learning_gw" {
  vpc_id = aws_vpc.tf_learning_vpc.id

  tags = {
    Name = "Terraform-Learning-GW"
  }
}

# Route Table
resource "aws_route_table" "tf_learning_rt" {
  vpc_id = aws_vpc.tf_learning_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf_learning_gw.id
  }

  tags = {
    Name = "Terraform-Learning-RT"
  }
}

# Associate Route Table with Subnet
resource "aws_route_table_association" "tf_learning_rta" {
  subnet_id      = aws_subnet.tf_learning_subnet.id
  route_table_id = aws_route_table.tf_learning_rt.id
}

# Security Group for EC2
resource "aws_security_group" "tf_learning_sg" {
  vpc_id = aws_vpc.tf_learning_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access (modify as needed)
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terraform-Learning-SG"
  }
}

# EC2 Instance for Terraform Learning
resource "aws_instance" "tf_learning_vm" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.tf_learning_subnet.id
  security_groups        = [aws_security_group.tf_learning_sg.name]
  associate_public_ip_address = true
  key_name               = var.aws_key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y unzip wget git
              wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip
              unzip terraform_1.5.0_linux_amd64.zip
              mv terraform /usr/local/bin/
              git clone https://github.com/brikis98/terraform-the-hard-way /home/ec2-user/terraform-the-hard-way
              chown -R ec2-user:ec2-user /home/ec2-user/terraform-the-hard-way
              EOF

  tags = {
    Name = "Terraform-Learning-VM"
  }
}

# Data Source for Latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# S3 Bucket for Terraform State
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "terraform-learning-state-${random_id.bucket_suffix.hex}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name = "Terraform-Learning-State"
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 8
}

# IAM Role for Terraform
resource "aws_iam_role" "tf_learning_role" {
  name = "TerraformLearningRole"

  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy_attachment" "tf_learning_attach" {
  role       = aws_iam_role.tf_learning_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_instance_profile" "tf_learning_profile" {
  name = "TerraformLearningProfile"
  role = aws_iam_role.tf_learning_role.name
}

# Output Values
output "ec2_public_ip" {
  description = "Public IP of the Terraform learning EC2 instance"
  value       = aws_instance.tf_learning_vm.public_ip
}

output "s3_bucket_name" {
  description = "Terraform state S3 bucket name"
  value       = aws_s3_bucket.tf_state_bucket.id
}
