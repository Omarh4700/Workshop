output "public_route_table_id" {
  description = "Public Route Table ID"
  value       = aws_route_table.public.id
}
output "private_route_table_id" {
  description = "Private Route Table ID"
  value       = aws_route_table.private.id
}
output "public_route_table_association_id" {
  description = "Public Route Table Association ID"
  value       = aws_route_table_association.public.id
}
output "private_route_table_association_id" {
  description = "Private Route Table Association ID"
  value       = aws_route_table_association.private.id
}
