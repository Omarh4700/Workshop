variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}
variable "admin_cidr_blocks" {
  description = "List of CIDR blocks allowed for SSH access (e.g., your office IP, VPN, bastion host)"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Must be overridden with actual admin IPs
}
