provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "AWS-EKS-GitOps-Platform"
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}