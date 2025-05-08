variable "db_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}
variable "db_name" {
  description = "The name of the database to create when the DB instance is created"
  type        = string
  default     = "rdsdb"
}
variable "engine" {
  type    = string
  default = "mysql"

  validation {
    condition     = contains(["aurora", "aurora-mysql", "aurora-postgresql", "custom-oracle-ee", "mariadb", "mysql", "oracle-ee", "postgres", "sqlserver-ee", "sqlserver-se", "sqlserver-ex", "sqlserver-web"], lower(var.engine))
    error_message = "Engine not recognized. See CreateDBInstance documentation for list of available engines: https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html ."
  }
}
variable "engine_version" {
  type    = string
  default = "8.0.26"
}
variable "instance_class" {
  type    = string
  default = "db.t2.micro"

  validation {
    condition     = contains(["db.t2.micro", "db.t2.small", "db.t2.medium", "db.t3.micro", "db.t3.small", "db.t3.medium"], lower(var.instance_class))
    error_message = "Instance class not recognized. Options: db.t2.micro, db.t2.small, db.t2.medium, db.t3.micro, db.t3.small, db.t3.medium."
  }
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "username" {
  description = "The name of the master user for the database instance"
  type        = string
  default     = "admin"
  validation {
    condition     = length(var.username) >= 1 && length(var.username) <= 16
    error_message = "Username must be between 1 and 16 characters."
  }
  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9]*$", var.username))
    error_message = "Username must start with a letter and contain only alphanumeric characters."
  }
}

variable "password" {
  description = "The password for the master database user"
  type        = string
  sensitive   = true
}
variable "vpc_security_group_ids" {
  description = "A list of VPC security groups to associate with the RDS instance"
  type        = string
}
variable "subnet_ids" {
  description = "A list of subnet IDs to associate with the RDS instance"
  type        = string
}
variable "multi_az" {
  type        = bool
  default     = false
  description = "Specifies if the DB instance is a Multi-AZ deployment"
  validation {
    condition     = var.multi_az == true || var.multi_az == false
    error_message = "multi_az must be either true or false."
  }
}

variable "publicly_accessible" {
  type    = bool
  default = false
}
variable "agent" {
  description = "The agent to use for the RDS instance"
  type        = string
  default     = "it-deployments-eks"
}
