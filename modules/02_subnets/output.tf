# Public Subnet IDs
output "availability_zone-A" {
    description = "The Availability Zone of the Subnet"
    value       = aws_subnet.public_subnet-A.availability_zone
}
output "availability_zone-B" {
    description = "The Availability Zone of the Subnet"
    value       = aws_subnet.public_subnet-B.availability_zone
}
# Public Subnet IDs
output "public_subnet-A-id-subnet" {
    description = "The ID of the Public Subnet"
    value       = aws_subnet.public_subnet-A.id
}
output "public_subnet-B-id-subnet" {
    description = "The ID of the Public Subnet"
    value       = aws_subnet.public_subnet-B.id
}
# Private Subnet IDs
output "private_subnet-A-id-subnet" {
    description = "The ID of the Public Subnet"
    value       = aws_subnet.private_subnet-A.id
}
output "private_subnet-B-id-subnet" {
    description = "The ID of the Public Subnet"
    value       = aws_subnet.private_subnet-B.id
}