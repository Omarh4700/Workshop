variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "aws_internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  type        = string
}

variable "public_subnet-B-id" {
  description = "List of Subnet IDs to associate with the Route Table"
  type        = string
}
variable "public_subnet-A-id" {
  description = "List of Subnet IDs to associate with the Route Table"
  type        = string
}

variable "private_subnet_A_id" {
  description = "List of Subnet IDs to associate with the Route Table"
  type        = string
}
variable "private_subnet_B_id" {
  description = "List of Subnet IDs to associate with the Route Table"
  type        = string
}