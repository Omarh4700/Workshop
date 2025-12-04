resource "aws_ecrpublic_repository" "vp-app-db" {
  repository_name = var.db_repo

  # lifecycle {
  #   prevent_destroy = true
  # }
}
resource "aws_ecrpublic_repository" "vp-app-tomcat" {
  repository_name = var.tomcat_repo

  # lifecycle {
  #   prevent_destroy = true
  # }
}
resource "aws_ecrpublic_repository" "vp-app-nginx" {
  repository_name = var.nginx_repo

  # lifecycle {
  #   prevent_destroy = true
  # }
}
