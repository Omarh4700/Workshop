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
