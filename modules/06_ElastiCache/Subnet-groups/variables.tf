variable "vpc_id" {
    description = "The custom vpc"
    type        = string
}
variable "private_subnet_A_id" {
    description = "The ID of the private subnet A"
    type        = string
}
variable "private_subnet_B_id" {
    description = "The ID of the private subnet B"
    type        = string
}
variable "memcached_subnet_group_name" {
    description = "The name of the ElastiCache subnet group"
    default     = "memcached-subnet-group"
    type        = string
}