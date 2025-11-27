variable "subnets" {
  description = "List of subnet IDs for the CLB"
  type        = list(string)
}

variable "security_groups" {
  description = "List of security group IDs for the CLB"
  type        = list(string)
}

variable "instances" {
  description = "List of instance IDs to attach to the CLB"
  type        = list(string)
}
