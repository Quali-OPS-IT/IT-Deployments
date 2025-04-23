resource "aws_db_instance" "quali_it_rds" {
  allocated_storage        = 20
  availability_zone        = "eu-west-1b"
  backup_window            = "05:08-05:38"
  ca_cert_identifier       = "rds-ca-rsa2048-g1"
  copy_tags_to_snapshot    = true
  db_name                  = "Quali_IT_RDS"
  db_subnet_group_name     = "default-vpc-038472e7ba5c25ed0"
  delete_automated_backups = true
  engine                   = "mysql"
  engine_version           = "8.0.40"
  identifier               = "quali-it-rds"
  instance_class           = "db.t4g.micro"
  kms_key_id               = "arn:aws:kms:eu-west-1:831926626521:key/b8a0c459-af18-49d6-acf0-d56d0be55cf1"
  license_model            = "general-public-license"
  maintenance_window       = "thu:01:05-thu:01:35"
  max_allocated_storage    = 1000
  option_group_name        = "default:mysql-8-0"
  parameter_group_name     = "default.mysql8.0"
  port                     = 3306
  publicly_accessible      = true
  skip_final_snapshot      = true
  storage_encrypted        = true
  storage_type             = "gp2"
  username                 = "admin"
  vpc_security_group_ids = [
    "sg-0e4488a42d9d3b19b"
  ]
  provider = aws.eu_west_1
}
resource "aws_vpc" "project_vpc" {
  tags = {
    Name = "project-vpc"
  }
  tags_all = {
    Name = "project-vpc"
  }
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  provider             = aws.eu_west_1
}
