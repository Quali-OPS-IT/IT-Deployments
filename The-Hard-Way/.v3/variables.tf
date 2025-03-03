# AWS Region
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "eu-west-1"
}

# AWS Key Pair for SSH Access
variable "aws_key_name" {
  description = "The AWS key pair name for accessing the EC2 instance"
  type        = string
}

# VPC CIDR Block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnet CIDR Block
variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# EC2 Instance Type
variable "ec2_instance_type" {
  description = "EC2 instance type for Terraform learning VM"
  type        = string
  default     = "t3.micro"
}

# Enable Cloud9 (Optional)
variable "enable_cloud9" {
  description = "Set to true to create a Cloud9 environment"
  type        = bool
  default     = true
}