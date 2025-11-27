resource "aws_elasticache_subnet_group" "memcached_subnet_group" {
  name       = var.memcached_subnet_group_name
  subnet_ids = [var.private_subnet_A_id, var.private_subnet_B_id]
  description = "ElastiCache subnet group for private subnets"

  tags = {
    Name = var.memcached_subnet_group_name
    Type = "ElastiCache-Subnet-Group"
  }
}