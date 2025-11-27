
output "username" {
  description = "The master username for the RDS instance"
  value       = var.db_username
}
output "password" {
  description = "The master password for the RDS instance"
  value       = var.db_password
}
output "RDS_Endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = replace(aws_db_instance.mysql_DB.endpoint, ":3306", "")
}
output "RDS_subnet_group_name" {
  description = "The name of the RDS DB subnet group"
  value       = var.RDS_subnet_group_name
}

output "RDS_Address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.mysql_DB.address
}
