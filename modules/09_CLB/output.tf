output "clb_dns_name" {
  description = "The DNS name of the CLB"
  value       = aws_elb.clb.dns_name
}
