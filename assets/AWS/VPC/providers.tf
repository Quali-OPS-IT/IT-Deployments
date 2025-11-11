terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "region" {
  type    = string
  default = "eu-west-1"   
}

provider "aws" {
  # Region can come from var or env (AWS_REGION / AWS_DEFAULT_REGION)
  region = coalesce(var.region, null)
}
