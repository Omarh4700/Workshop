resource "aws_elasticache_parameter_group" "memcached_pg" {
  description = "memcached-parameter-group for Memcached 1.6"
  name        = var.memcached_parameter_group_name   # Name of the DB parameter group
  family      = var.memcached_parameter_group_family     # Parameter group family for MySQL Community Edition

  tags = {
    Name = var.memcached_parameter_group_name
    Type = "DB-Parameter-Group"
  }
}