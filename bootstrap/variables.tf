variable "aws_region" {
  type        = string
  description = "AWS region for the state bucket."
  default     = "us-east-1"
}

variable "bucket_prefix" {
  type        = string
  description = "Prefix for the globally unique S3 state bucket."
  default     = "eks-portfolio-tfstate"
}