output "ami_id" {
  value       = aws_instance.this.ami
  description = "Resolved AMI ID used for the instance."
}

output "instance_id" {
  value       = aws_instance.this.id
  description = "EC2 instance ID."
}

output "private_ip" {
  value       = aws_instance.this.private_ip
  description = "Private IP address."
}

output "public_ip" {
  value       = aws_instance.this.public_ip
  description = "Public IP address (if assigned)."
}

output "security_group_ids" {
  value       = aws_instance.this.vpc_security_group_ids
  description = "Security Group IDs attached to the instance."
}
