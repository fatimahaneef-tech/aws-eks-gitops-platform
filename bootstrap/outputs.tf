output "state_bucket_name" {
  description = "The globally unique S3 bucket name created for Terraform remote state."
  value       = aws_s3_bucket.state.bucket
}

output "backend_configuration_instructions" {
  description = "Copy and paste this block into terraform/versions.tf"
  value       = <<EOT
backend "s3" {
  bucket       = "${aws_s3_bucket.state.bucket}"
  key          = "platform/eks/terraform.tfstate"
  region       = "${var.aws_region}"
  use_lockfile = true
}
EOT
}