resource "aws_ecr_repository" "app" {
  name                 = "portfolio-fastapi-app"
  image_tag_mutability = "IMMUTABLE" # Prevents tag overwriting; enforces unique Git SHAs

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name = "portfolio-fastapi-app"
  }
}

# Lifecycle Policy: retain only the last 5 images to keep storage costs negligible
resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Keep only the 5 most recent container images"
        selection = {
          tagStatus   = "any"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 14
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}