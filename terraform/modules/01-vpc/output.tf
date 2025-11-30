output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.k8s_vpc.id
}

output "igw_id" {
  description = "Internet Gateway ID"
  value       = aws_internet_gateway.k8s_igw.id
}
