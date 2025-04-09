variable "region" {
    type = string
    default = "eu-west-1"
  
}
variable "description" {
    type = string
    default = "KMS Key from TF"
}

variable "enable_key_rotation" {
    type = bool
    default = true
}
