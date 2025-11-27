resource "aws_elasticache_cluster" "memcached_cluster" {
  cluster_id           = var.cluster_id
  engine               = var.engine
  engine_version       = var.engine_version
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.memcached_parameter_group_name
  subnet_group_name    = var.memcached_subnet_group_name
  security_group_ids   = [var.elasti_cache_sg_id]
  port                 = var.port
  tags = {
    Name = var.cluster_id
    Type = "ElastiCache-Cluster"
  }
}
