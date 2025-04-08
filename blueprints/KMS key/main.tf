terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0.0"
    }
  }
}

# moving a comment
provider "aws" {
  region = var.region
}

# moving a comment
resource "aws_kms_key" "kms_key" {
  description             = "${var.description}-key"
  enable_key_rotation = var.enable_key_rotation
  deletion_window_in_days = var.deletion_window_in_days
}
