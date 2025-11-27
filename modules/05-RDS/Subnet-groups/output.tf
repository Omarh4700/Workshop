output "subnet_group_id" {
    description = "The ID of the RDS DB subnet group"
    value       = aws_db_subnet_group.RDS_subnet_group.id
}
output "RDS_subnet_group_name" {
    description = "The name of the RDS DB subnet group"
    value       = aws_db_subnet_group.RDS_subnet_group.name
}