output "vpc_id" {
  value = aws_vpc.quali_it_vpc.id
}

output "subnet_id" {
  value = aws_subnet.app_subnet.id
}

output "security_group_id" {
  value = aws_security_group.default_sg.id
}

output "vpc_cidr" {
  value = aws_vpc.quali_it_vpc.cidr_block
}
