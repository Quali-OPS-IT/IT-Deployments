variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-1"
}

# AMI ID
variable "ami_id" {
  type    = string
  default = "ami-073151717783c9ea5" # Ubuntu 20.04 LTS
}

# Instance type 
## add validation to ensure the instance type is valid
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched"
  type        = string
}
