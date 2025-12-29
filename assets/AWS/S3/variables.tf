variable "bucket_name" {
  description = "The name of the S3 bucket (must be globally unique, alphanumeric, and between 3 to 63 characters long)"
  type        = string

  validation {
    condition     = length(var.bucket_name) >= 3 && length(var.bucket_name) <= 63
    error_message = "The bucket name must be between 3 and 63 characters long."
  }

  validation {
    condition     = can(regex("^[a-z0-9.-]+$", var.bucket_name))
    error_message = "The bucket name must contain only lowercase letters, numbers, periods, and hyphens."
  }
}

variable "region" {
  description = "The AWS region to create the S3 bucket in"
  type        = string
  default     = "eu-west-1"
}

variable "agent" {
  description = "The Torque agent that will be used to create the S3 bucket"
  type        = string
  default     = "eks"
}
variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "eu-west-1"
}