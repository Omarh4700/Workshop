output "vpc_id" {
    description = "The ID of the VPC"
    value       = aws_vpc.vp-app_VPC.id
}
output "internet_gateway_id" {
    description = "The ID of the Internet Gateway"
    value       = aws_internet_gateway.vp-app_IGW.id
}