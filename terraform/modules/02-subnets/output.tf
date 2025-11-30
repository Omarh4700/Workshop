output "public_subnet_id" {
  description = "Public Subnet ID"
  value       = aws_subnet.public.id
}
output "private_subnet_id" {
  description = "Private Subnet ID"
  value       = aws_subnet.private.id
}

output "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  value       = aws_subnet.public.cidr_block
}

output "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  value       = aws_subnet.private.cidr_block
}
