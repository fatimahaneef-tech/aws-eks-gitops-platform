output "cluster_name" {
  description = "The name of the provisioned EKS cluster."
  value       = aws_eks_cluster.main.name
}

output "cluster_endpoint" {
  description = "The Kubernetes API server endpoint."
  value       = aws_eks_cluster.main.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster."
  value       = aws_eks_cluster.main.certificate_authority[0].data
  sensitive   = true
}

output "ecr_repository_url" {
  description = "The URL of the Amazon ECR repository for application container images."
  value       = aws_ecr_repository.app.repository_url
}

output "configure_kubectl_command" {
  description = "AWS CLI command to configure local kubeconfig."
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${aws_eks_cluster.main.name}"
}