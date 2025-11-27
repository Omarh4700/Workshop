output "subnet_group_id" {
    description = "The ID of the memcached subnet group"
    value       = aws_elasticache_subnet_group.memcached_subnet_group.id
}
output "memcached_subnet_group_name" {
    description = "The name of the memcached subnet group"
    value       = var.memcached_subnet_group_name
}