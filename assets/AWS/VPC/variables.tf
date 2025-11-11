variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "az" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "eu-west-1a"
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Name = "quali-it-vpc"
  }
}

variable "agent" {
  description = "Agent ID for the Quali IT platform"
  type        = string
  default     = "it-eks"
}
