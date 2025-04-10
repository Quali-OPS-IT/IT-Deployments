variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1" 
}

# Common tags (example)
variable "common_tags" {
  type = map(string)
  default = {
    Project   = "IT-Torque-Learning"
    ManagedBy = "Terraform"
  }
}

# Additional tags (example)
variable "tags" {
  type = map(string)
  default = {}
}

# AMI ID
variable "ami_id" {
  type    = string
  default = "ami-073151717783c9ea5"  # Ubuntu 20.04 LTS
}

# Instance type
variable "instance_type" {
  type    = string
  default = "t2.micro"  
}