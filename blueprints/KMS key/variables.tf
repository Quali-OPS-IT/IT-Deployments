variable "region" {
    type = string
    default = "eu-west-1"
  
}
variable "description" {
    type = string
    default = "KMS Key from TF"
}

variable "deletion_window_in_days" {
    type = number
    default = "10"
}

variable "enable_key_rotation" {
    type = bool
    default = true
}
