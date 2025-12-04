output "k8s_nodes_instance_profile_name" {
  description = "Name of the K8s nodes instance profile"
  value       = aws_iam_instance_profile.k8s_nodes_profile.name
}

output "k8s_nodes_role_arn" {
  description = "ARN of the K8s nodes IAM role"
  value       = aws_iam_role.k8s_nodes_role.arn
}

output "jenkins_instance_profile_name" {
  description = "Name of the Jenkins instance profile"
  value       = aws_iam_instance_profile.jenkins_profile.name
}

output "jenkins_role_arn" {
  description = "ARN of the Jenkins IAM role"
  value       = aws_iam_role.jenkins_role.arn
}
