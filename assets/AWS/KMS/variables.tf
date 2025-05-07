variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "description" {
  type    = string
  default = "KMS Key from TF"
}

variable "deletion_window_in_days" {
  type    = number
  default = 10

  validation {
    condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
    error_message = "The deletion window in days must be between 7 and 30 days."
  }
}

variable "enable_key_rotation" {
  type    = bool
  default = true
}

variable "agent" {
  type    = string
  default = "it-deployments-eks"
}
