# Production AWS EKS Platform — Terraform + GitOps + GitHub Actions + Argo CD

![Terraform](https://img.shields.io/badge/Terraform-1.10%2B-purple?logo=terraform)
![Kubernetes](https://img.shields.io/badge/Kubernetes-1.31-blue?logo=kubernetes)
![AWS](https://img.shields.io/badge/AWS-EKS-orange?logo=amazon-aws)
![ArgoCD](https://img.shields.io/badge/GitOps-Argo%20CD-red?logo=argo)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-OIDC%20Authenticated-green?logo=github-actions)

An enterprise-ready, cost-conscious Infrastructure as Code (IaC) and GitOps delivery pipeline deploying a containerized Python FastAPI microservice to Amazon Elastic Kubernetes Service (EKS).

## Architectural Highlights
- **VPC & Subnet Architecture:** Multi-AZ network featuring public subnets for ingress and private subnets for compute workloads.
- **EKS Managed Node Groups:** Automated patching, restricted IAM roles, and private node placement.
- **Remote State with Native S3 Locking:** Uses Terraform 1.10+ native S3 lockfiles (`use_lockfile = true`), eliminating the need for legacy DynamoDB lock tables.
- **Keyless GitHub Actions OIDC:** Short-lived AWS STS token exchange eliminates long-lived IAM access keys.
- **True GitOps Reconciliation:** Argo CD operates within the cluster to reconcile Kubernetes desired state automatically against Git commits.
- **Security-First Pods:** Non-root execution (`UID 10001`), read-only root filesystems, dropped Linux capabilities, and strict health/readiness probes.

## Repository Organization

├── .github/workflows/ # CI pipelines (Terraform lint/plan, Docker build, ECR push)
├── app/ # Python FastAPI service, multi-stage Dockerfile, tests
├── argocd/ # Argo CD Application declaration
├── bootstrap/ # Standalone Terraform to provision the S3 remote state bucket
├── docs/ # Deployment runbooks, cost guides, and security threat models
├── kubernetes/ # Hardened K8s manifests (Deployment, Service, NetworkPolicy)
└── terraform/ # Core cloud infrastructure (VPC, EKS, Node Group, ECR, IAM)
code
Code
## Quick Start (Zero-Cost Local Validation)
You can validate the application and infrastructure locally without spending any AWS budget:

1. **Test Application Locally:**
   ```bash
   cd app
   docker build -t eks-portfolio-app:local .
   docker run -p 8000:8000 eks-portfolio-app:local
   curl http://localhost:8000/healthz
Validate Terraform Configuration:
code
Bash
cd terraform
terraform fmt -check
terraform init -backend=false
terraform validate
Complete Deployment & Cleanup Runbook
For full step-by-step instructions on provisioning AWS resources, deploying via Argo CD, and destroying infrastructure to avoid charges, see docs/deployment-guide.md.
Cost & Safety Policy
This project is optimized for portfolio demonstrations with an hourly cost of approximately $0.25/hour.
Follow docs/cost-guide.md to inspect resources and tear down clusters after testing.
code
Code
---

#### File: `/docs/deployment-guide.md`
**Relative Path:** `docs/deployment-guide.md`

```markdown
# Comprehensive Deployment Guide: From Zero to Running EKS Cluster

## Phase 0: Prerequisites & AWS Authentication
Before running Terraform, ensure your local terminal is authenticated to AWS:

```bash
# 1. Verify AWS CLI is installed
aws --version

# 2. Configure your AWS credentials (create an IAM user with AdministratorAccess in your sandbox)
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Default region: us-east-1
# Default output format: json

# 3. Verify your caller identity
aws sts get-caller-identity