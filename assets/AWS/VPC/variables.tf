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
  default     = "it-deployments-eks"
}

variable "security_group_ingress" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
}
