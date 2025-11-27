output "parameter_group_id" {
    description = "The ID of the ElastiCache parameter group"
    value       = aws_elasticache_parameter_group.memcached_pg.id
}
output "memcached_parameter_group_name" {
    description = "The name of the Memcached parameter group"
    value       = var.memcached_parameter_group_name
}