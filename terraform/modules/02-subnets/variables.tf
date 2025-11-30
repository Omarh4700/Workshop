variable "vpc_id" {
  description = "VPC ID"
  type        = string
}
variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  type        = string
  default     = "192.168.10.0/24"
}
variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  type        = string
  default     = "192.168.20.0/24"
}
variable "availability_zone" {
  description = "Availability Zone"
  type        = string
  default     = "us-east-1a"
}
