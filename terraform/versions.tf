terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.80.0"
    }
  }

  # REMOTE STATE BACKEND:
  # Once you run Phase 3 (Bootstrap S3 Bucket), uncomment this block, replace
  # the bucket name with your actual bucket name, and run `terraform init -migrate-state`.
  #
   backend "s3" {
     bucket       = "eks-portfolio-tfstate-f4vot3gr"
     key          = "platform/eks/terraform.tfstate"
     region       = "us-east-1"
     use_lockfile = true # Native S3 locking (Terraform 1.10+)
   }
}