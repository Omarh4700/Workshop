output "ElastiCache_Endpoint" {
    description = "The endpoint of the ElastiCache cluster"
    value       = aws_elasticache_cluster.memcached_cluster.cache_nodes[0].address # First node address
}

output "memcached_subnet_group_name" {
    description = "The name of the ElastiCache subnet group"
    value       = var.memcached_subnet_group_name
}
output "memcached_parameter_group_name" {
    description = "The name of the ElastiCache parameter group"
    value       = var.memcached_parameter_group_name
}