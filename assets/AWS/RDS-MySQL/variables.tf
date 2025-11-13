variable "db_name" {
  description = "Database name to create (schema). Must begin with a letter."
  type        = string
  default     = null
}

variable "engine_version" {
  description = "MySQL engine version (e.g., 8.0.36)."
  type        = string
}

variable "db_user" {
  description = "Master username."
  type        = string
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
  description = "Allocated storage in GB."
  type        = number
  default     = 20
}

variable "db_vm_type" {
  description = "DB instance class, e.g., db.t3.medium, db.r6g.large."
  type        = string
}

variable "public" {
  description = "Whether the instance gets a public IP (publicly_accessible)."
  type        = bool
  default     = false
}

variable "subnet_ids" {
  description = "Private subnet IDs for the DB subnet group (2+ recommended)."
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
