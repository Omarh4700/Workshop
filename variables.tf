variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "admin_cidr_blocks" {
  description = "List of CIDR blocks allowed to access admin resources (e.g., SSH)"
  type        = list(string)
  default     = ["0.0.0.0/0"] # WARNING: This allows access from anywhere. Restrict to your IP for production!
}
