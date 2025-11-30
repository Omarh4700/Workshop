variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "natgw_id" {
  description = "NAT Gateway ID"
  type        = string
}
variable "igw_id" {
  description = "Internet Gateway ID"
  type        = string
}
variable "public_subnet_id" {
  description = "Public Subnet ID"
  type        = string
}
variable "private_subnet_id" {
  description = "Private Subnet ID"
  type        = string
}
