output "grafana_clb_dns_name" {
  value = aws_elb.grafana_clb.dns_name
}
output "tomcat_clb_dns_name" {
  value = aws_elb.tomcat_clb.dns_name
}
