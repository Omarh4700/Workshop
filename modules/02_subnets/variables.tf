variable "vpc_id" {
    description = "The ID of the VPC where the subnet will be created"
    type        = string
}
# Public Subnet Cidrs
variable "public_subnet_cidr" {
    description = "The CIDR block for the public subnet"
    type        = string
    default = "192.168.10.0/24"
}
variable "public_subnet_cidr-B" {
    description = "The CIDR block for the second public subnet"
    type        = string
    default = "192.168.20.0/24"
}
# Private Subnet Cidrs
variable "private_subnet_cidr-A" {
    description = "The CIDR block for the first private subnet"
    type        = string
    default = "192.168.56.0/24"
}
variable "private_subnet_cidr-B" {
    description = "The CIDR block for the second private subnet"
    type        = string
    default = "192.168.66.0/24"
}
# AZs 
variable "availability_zone-A" {
    description = "The availability zone for the subnet"
    default =         "us-east-1a"
}
variable "availability_zone-B" {
    description = "The availability zone for the subnet"
    default =         "us-east-1b"
  
}



