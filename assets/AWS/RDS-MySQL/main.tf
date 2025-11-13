terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# Optional: create a DB subnet group if subnet_ids provided
resource "aws_db_subnet_group" "this" {
  count       = length(var.subnet_ids) > 0 ? 1 : 0
  name        = "rds-mysql-${substr(md5(join(",", var.subnet_ids)), 0, 8)}"
  description = "Subnet group for RDS MySQL"
  subnet_ids  = var.subnet_ids
}

resource "aws_db_instance" "this" {
  engine                     = "mysql"
  engine_version             = var.engine_version
  instance_class             = var.db_vm_type

  # Storage
  storage_type               = var.storage_type
  allocated_storage          = var.storage_size

  # Credentials / DB name
  username                   = var.db_user
  password                   = var.db_pass
  db_name                    = var.db_name

  # Networking
  publicly_accessible        = var.public
  vpc_security_group_ids     = var.vpc_security_group_ids
  db_subnet_group_name       = length(var.subnet_ids) > 0 ? aws_db_subnet_group.this[0].name : null
  multi_az                   = var.multi_az

  # Backups & maintenance
  backup_retention_period    = var.backup_retention_days
  apply_immediately          = true

  # Safety
  deletion_protection        = var.deletion_protection
  skip_final_snapshot        = true

  # Recommended flags
  auto_minor_version_upgrade = true
}
