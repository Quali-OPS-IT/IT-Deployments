variable "sandbox_id" {
  type        = string
  description = "Unique sandbox or environment ID"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where RDS will be deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for DB subnet group"
}

variable "allowed_cidrs" {
  type        = list(string)
  default     = ["0.0.0.0/0"]
  description = "CIDR blocks allowed to access the DB"
}

variable "db_name" {
  type        = string
  description = "Name of the database to create"
  default     = "appdb"
}

variable "engine" {
  type        = string
  description = "Database engine type"
  default     = "mysql"
}

variable "engine_version" {
  type        = string
  description = "Engine version"
  default     = "8.0"
}

variable "instance_class" {
  type        = string
  description = "Instance type for RDS"
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  type        = number
  default     = 20
  description = "Storage size in GB"
}

variable "storage_type" {
  type        = string
  default     = "gp3"
}

variable "username" {
  type        = string
  description = "Database admin username"
  default     = "admin"
}

variable "port" {
  type        = number
  default     = 3306
}

variable "publicly_accessible" {
  type        = bool
  default     = false
}

variable "multi_az" {
  type        = bool
  default     = false
}

variable "deletion_protection" {
  type        = bool
  default     = false
}

variable "skip_final_snapshot" {
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  type        = number
  default     = 7
}

variable "environment" {
  type        = string
  default     = "dev"
}
