terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!@#%^*()-_=+[]{}"
}

# Security Group for RDS
resource "aws_security_group" "rds_sg" {
  name        = "rds-${var.sandbox_id}-sg"
  description = "RDS security group for sandbox ${var.sandbox_id}"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidrs
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-${var.sandbox_id}-sg"
  }
}

# Subnet Group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-${var.sandbox_id}-subnet-group"
  subnet_ids = var.subnet_ids
  tags = {
    Name = "rds-${var.sandbox_id}-subnet-group"
  }
}

# RDS Instance
resource "aws_db_instance" "rds_instance" {
  identifier              = "rds-${var.sandbox_id}"
  db_name                 = var.db_name
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  storage_type            = var.storage_type
  username                = var.username
  password                = random_password.password.result
  port                    = var.port
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  publicly_accessible     = var.publicly_accessible
  deletion_protection     = var.deletion_protection
  multi_az                = var.multi_az
  skip_final_snapshot     = var.skip_final_snapshot
  backup_retention_period = var.backup_retention_period
  apply_immediately       = true

  tags = {
    Name        = "rds-${var.sandbox_id}"
    Environment = var.environment
  }
}
