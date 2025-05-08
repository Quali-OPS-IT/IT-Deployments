resource "aws_db_subnet_group" "rds" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "rds" {
  identifier             = var.db_identifier
  allocated_storage      = var.allocated_storage
  engine                 = var.engine
  engine_version         = var.engine_version
  instance_class         = var.instance_class
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = var.vpc_security_group_ids
  multi_az               = var.multi_az
  publicly_accessible    = var.publicly_accessible
  skip_final_snapshot    = true
}
