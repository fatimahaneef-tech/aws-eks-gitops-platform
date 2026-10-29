variable "aws_region" {
  type        = string
  description = "AWS region for all infrastructure resources."
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment name (e.g., dev, staging, prod)."
  default     = "dev"
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS Kubernetes cluster."
  default     = "eks-portfolio-cluster"
}

variable "kubernetes_version" {
  type        = string
  description = "Desired Kubernetes control plane version."
  default     = "1.31"
}

variable "vpc_cidr" {
  type        = string
  description = "Base CIDR block for the Virtual Private Cloud."
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for the two public subnets."
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

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