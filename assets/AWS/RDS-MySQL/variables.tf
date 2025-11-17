variable "db_name" {
  description = "DataBase name to create (schema). Must begin with a letter."
  type        = string
}

variable "engine_version" {
  description = "Exact MySQL engine version. Leave null to let AWS pick the current default."
  type        = string
  default     = null
}

variable "db_user" {
  description = "Master username."
  type        = string
  default     = "admin"
}

variable "db_pass" {
  description = "Master password."
  type        = string
  sensitive   = true
}

variable "storage_type" {
  description = "Storage type: gp3 (recommended), gp2, io1, or standard (magnetic)."
  type        = string
  default     = "gp3"
  validation {
    condition     = contains(["gp3","gp2","io1","standard"], lower(var.storage_type))
    error_message = "storage_type must be one of: gp3, gp2, io1, standard."
  }
}

variable "storage_size" {
  description = "Allocated storage in GB. Minimum: 20 GiB. Maximum: 65,536 GiB."
  type        = number
  default     = 20
}

variable "db_vm_type" {
  description = "RDS DB instance class (e.g. db.t3.micro, db.t3.small, db.t4g.micro)."
  type        = string
  default     = "db.t3.micro"
}

variable "public" {
  description = "Whether the instance gets a public IP."
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "Private subnet IDs for the DB subnet group."
  type        = list(string)
  default     = []
}

variable "vpc_security_group_ids" {
  description = "VPC Security Group IDs to attach to the DB instance."
  type        = list(string)
  default     = []
}

variable "multi_az" {
  description = "Whether to create a standby in another AZ."
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "Protect DB from deletion."
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Automated backup retention in days."
  type        = number
  default     = 7
}
