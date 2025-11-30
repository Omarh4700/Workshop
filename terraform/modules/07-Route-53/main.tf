resource "aws_route53_zone" "k8s_private_zone" {
  name = var.zone_name
  vpc {
    vpc_id = var.vpc_id
  }
  comment = "K8s Private Hosted Zone DNS"
}

resource "aws_route53_record" "k8s_master" {
  zone_id = aws_route53_zone.k8s_private_zone.zone_id
  name    = "master.${var.zone_name}"
  type    = "A"
  ttl     = 300
  records = [var.master_private_ip]
}

resource "aws_route53_record" "k8s_worker1" {
  zone_id = aws_route53_zone.k8s_private_zone.zone_id
  name    = "worker1.${var.zone_name}"
  type    = "A"
  ttl     = 300
  records = [var.worker1_private_ip]
}

resource "aws_route53_record" "k8s_worker2" {
  zone_id = aws_route53_zone.k8s_private_zone.zone_id
  name    = "worker2.${var.zone_name}"
  type    = "A"
  ttl     = 300
  records = [var.worker2_private_ip]
}
resource "aws_route53_record" "bastion" {
  zone_id = aws_route53_zone.k8s_private_zone.zone_id
  name    = "bastion.${var.zone_name}"
  type    = "A"
  ttl     = 300
  records = [var.bastion_public_ip]
}
