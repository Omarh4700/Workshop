output "db_repo_arn" {
  value = aws_ecrpublic_repository.vp-app-db.arn
}

output "tomcat_repo_arn" {
  value = aws_ecrpublic_repository.vp-app-tomcat.arn
}
