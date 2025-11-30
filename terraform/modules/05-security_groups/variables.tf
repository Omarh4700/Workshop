variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_cidr" {
  type        = string
  description = "Public Subnet CIDR"
}

variable "private_subnet_cidr" {
  type        = string
  description = "Private Subnet CIDR"
}
