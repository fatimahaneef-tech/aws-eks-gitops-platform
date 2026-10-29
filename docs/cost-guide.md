---

#### File: `/docs/cost-guide.md`
**Relative Path:** `docs/cost-guide.md`

```markdown
# AWS Cost Optimization & Budget Protection Guide

## Hourly Cost Breakdown (us-east-1)
| Component | Metric | Rate | 4-Hour Demo Cost |
| :--- | :--- | :--- | :--- |
| Amazon EKS Control Plane | Hourly | $0.100 / hr | $0.40 |
| EC2 Node (1x `t3.medium`) | Hourly | $0.0416 / hr | $0.17 |
| Single NAT Gateway | Hourly | $0.045 / hr | $0.18 |
| EBS Volume (20GB gp3) | Monthly pro-rated | $0.08 / GB-mo | $0.01 |
| S3 & ECR Storage | Storage + API | Pennies | $0.02 |
| **Total** | | **~$0.19 / hr** | **~$0.78** |

## How to Avoid Unwanted Charges
1. **Never Leave Clusters Running Overnight:** An idle EKS cluster costs ~$2.50 per day (~$75/month) even with zero traffic.
2. **Single NAT Gateway:** Production environments deploy one NAT Gateway per Availability Zone (3 AZs = ~$100/mo). This project deploys **only one** NAT Gateway across private subnets, cutting networking costs by 66%.
3. **No Load Balancers by Default:** AWS Application Load Balancers cost ~$16/month. We test service endpoints using `kubectl port-forward` during portfolio reviews.

## Verification Checklist After `terraform destroy`
Always log into the AWS Management Console after teardown to verify that all resources were terminated:
- [ ] **EKS Console:** Clusters list is empty.
- [ ] **EC2 Console:** 0 instances in `running` state.
- [ ] **VPC Console > NAT Gateways:** All NAT Gateways show `deleted`.
- [ ] **EC2 Console > Elastic IPs:** 0 allocated Elastic IPs (unattached EIPs cost $0.005/hr).
- [ ] **VPC Console > Volumes:** 0 EBS volumes in `available` state.