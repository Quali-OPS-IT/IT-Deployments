variable "db_name" {
  description = "The name of the database to create when the DB instance is created."
  type        = string

  validation {
    condition     = length(var.db_name) >= 1 && length(var.db_name) <= 64 && regex("^[a-zA-Z0-9_]+$", var.db_name)
    error_message = "The database name must be 1-64 characters long and can only contain alphanumeric characters and underscores."
  }
}
