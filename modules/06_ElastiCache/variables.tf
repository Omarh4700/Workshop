variable "vpc_id" {
    description  = "The ID of the VPC where the ElastiCache cluster will be deployed"
    type         = string
}
variable "cluster_id" {
    description  = "The ID of the ElastiCache cluster"
    default      = "memcached-cluster"
    type         = string
}
#----------------------------------------------------------
variable "engine" {
    description  = "The ElastiCache engine to use"
    default      = "memcached"
    type         = string
}
#----------------------------------------------------------
variable "engine_version" {
    description  = "The version of the ElastiCache engine"
    default      = "1.6.22"
    type         = string
}
#----------------------------------------------------------
variable "node_type" {
    description  = "The instance type of the ElastiCache node"
    default      = "cache.t3.medium"
    type         = string
}
#----------------------------------------------------------
variable "num_cache_nodes" {
    description  = "The number of cache nodes in the ElastiCache cluster"
    default      = 1
    type         = number
}
#----------------------------------------------------------
#----------------------------------------------------------
variable "port" {
    description  = "The port on which the ElastiCache cluster will listen"
    default      = 11211
    type         = number
}
#----------------------------------------------------------
variable "elasti_cache_sg_id" {
    description  = "The ID of the ElastiCache security group"
    type         = string
}
variable "memcached_parameter_group_name" {
    description  = "The name of the ElastiCache parameter group"
    type         = string
}
variable "memcached_subnet_group_name" {
    description  = "The name of the ElastiCache subnet group"
    type         = string
}
