variable "memcached_parameter_group_name" {
    description = "The name of the DB parameter group"
    default     = "memcached-pg"
    type        = string
}
variable "memcached_parameter_group_family" {
    description = "The family of the DB parameter group"
    default     = "memcached1.6"
    type        = string
}