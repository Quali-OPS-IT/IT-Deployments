output "rds_endpoint" {
  description = "Database endpoint"
  value       = aws_db_instance.rds_instance.endpoint
}

output "rds_port" {
  description = "Database port"
  value       = aws_db_instance.rds_instance.port
}

output "rds_username" {
  description = "Database master username"
  value       = aws_db_instance.rds_instance.username
}

output "rds_password" {
  description = "Generated database password"
  value       = random_password.password.result
  sensitive   = true
}

output "rds_sg_id" {
  description = "RDS Security Group ID"
  value       = aws_security_group.rds_sg.id
}
