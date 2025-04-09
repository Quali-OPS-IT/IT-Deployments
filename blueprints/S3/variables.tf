variable "bucket_name" {
  description = "The name of the S3 bucket (must be globally unique)"
  type        = string
}
variable "region" {
  description = "The AWS region to create the S3 bucket in"
  type        = string
  default     = "ue-west-1"
}
