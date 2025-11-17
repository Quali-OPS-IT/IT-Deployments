output "endpoint" {
  value       = aws_db_instance.MySQL.endpoint
  description = "RDS endpoint (hostname)."
}

output "port" {
  value       = aws_db_instance.MySQL.port
  description = "RDS port."
}

output "arn" {
  value       = aws_db_instance.MySQL.arn
  description = "RDS instance ARN."
}

output "id" {
  value       = aws_db_instance.MySQL.id
  description = "RDS instance ID."
}
