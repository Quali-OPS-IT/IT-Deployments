terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Adjust based on your Terraform version
    }
  }
}

provider "aws" {
  region = var.aws_region
  # AWS credentials will be automatically picked up from environment variables
}

resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = merge(
    var.common_tags, # Use common_tags variable directly
    var.tags,        # Use tags variable directly
    {                # Manual tags
      Name = "Torque-EC2"
    }
  )
}
