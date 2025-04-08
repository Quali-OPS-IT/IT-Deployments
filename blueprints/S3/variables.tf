variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
    default     = "quali-it-s3"
}

variable "versioning_enabled" {
  description = "Enable versioning for the S3 bucket"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
variable "aws_region" {
  description = "The AWS region to deploy the S3 bucket"
  type        = string
  default     = "eu-west-1"
}
