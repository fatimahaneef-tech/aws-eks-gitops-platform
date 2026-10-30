variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the two private subnets where worker nodes run."
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "node_instance_types" {
  type        = list(string)
  description = "EC2 instance types for the EKS managed node group."
  default     = ["t3.medium"]
}

variable "node_desired_size" {
  type        = number
  description = "Desired count of worker nodes (1 for minimal cost demo)."
  default     = 1
}

variable "node_min_size" {
  type        = number
  description = "Minimum count of worker nodes in the auto-scaling group."
  default     = 1
}

variable "node_max_size" {
  type        = number
  description = "Maximum count of worker nodes in the auto-scaling group."
  default     = 2
}

variable "github_actions_repo" {
  type        = string
  description = "GitHub repository allowed to assume the AWS OIDC role. Format: owner/repo."
  default     = "fatimahaneef-tech/aws-eks-gitops-platform"
}

variable "github_actions_branch" {
  type        = string
  description = "Git branch allowed to assume the AWS OIDC role."
  default     = "main"
}

variable "github_actions_role_name" {
  type        = string
  description = "Name of the IAM role used by GitHub Actions to push containers to ECR."
  default     = "github-actions-ecr-push"
}