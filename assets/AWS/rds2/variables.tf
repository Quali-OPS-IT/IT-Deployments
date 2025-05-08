variable "db_identifier" {}
variable "db_name" {}
variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "allocated_storage" {}
variable "username" {}
variable "password" {}
variable "vpc_security_group_ids" {}
variable "subnet_ids" {}
variable "multi_az" {
  type    = bool
  default = false
}

variable "publicly_accessible" {
  type    = bool
  default = false
}
