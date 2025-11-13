output "endpoint" {
  value       = aws_db_instance.this.address
  description = "RDS endpoint (hostname)."
}

output "port" {
  value       = aws_db_instance.this.port
  description = "RDS port."
}

output "arn" {
  value       = aws_db_instance.this.arn
  description = "RDS instance ARN."
}

output "id" {
  value       = aws_db_instance.this.id
  description = "RDS instance ID."
}
