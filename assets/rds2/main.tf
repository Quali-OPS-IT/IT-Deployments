resource "aws_db_instance" "rds_it_test_db01" {
  allocated_storage        = 20
  availability_zone        = "eu-west-1a"
  backup_window            = "01:46-02:16"
  ca_cert_identifier       = "rds-ca-rsa2048-g1"
  copy_tags_to_snapshot    = true
  db_name                  = "var.db_name"
  db_subnet_group_name     = "default-vpc-0fcd99021d5ec4bc4"
  delete_automated_backups = true
  engine                   = "mysql"
  engine_version           = "8.0.40"
  identifier               = "var.db_name"
  instance_class           = "db.t4g.micro"
  kms_key_id               = "arn:aws:kms:eu-west-1:831926626521:key/b76caa31-7c85-4cf1-9902-c7d7d76c39c9"
  license_model            = "general-public-license"
  maintenance_window       = "wed:02:36-wed:03:06"
  max_allocated_storage    = 100
  option_group_name        = "default:mysql-8-0"
  parameter_group_name     = "default.mysql8.0"
  port                     = 3306
  publicly_accessible      = true
  skip_final_snapshot      = true
  storage_encrypted        = true
  storage_type             = "gp2"
  username                 = "admin"
  vpc_security_group_ids = [
    "sg-04814fc8fb12f4040"
  ]
  provider = aws.eu_west_1
}
resource "aws_vpc" "test_rds_vpc" {
  tags = {
    Name = "test-rds-vpc"
  }
  tags_all = {
    Name = "test-rds-vpc"
  }
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"
  provider             = aws.eu_west_1
}
