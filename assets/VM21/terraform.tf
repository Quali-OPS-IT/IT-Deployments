terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.0.0"
    }
  }
    backend "s3" {
    bucket         = "torque-tfstate-831926626521"
    key            = "terraform.tfstate"
    region         = "eu-west-1"
  }

}