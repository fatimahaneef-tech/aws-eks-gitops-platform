# Security Architecture & Threat Model

## 1. Zero-Credential CI/CD (GitHub Actions OIDC)
Traditional CI/CD pipelines store static AWS IAM access keys in GitHub Secrets. If an attacker gains read access to repository secrets or runs malicious code in a Pull Request, those credentials can be exfiltrated.

**Our Mitigation (OIDC):**
1. GitHub Actions issues an OpenID Connect (OIDC) identity token signed by GitHub's cryptographic key.
2. The workflow presents this token to AWS STS using `AssumeRoleWithWebIdentity`.
3. AWS verifies the cryptographic signature and checks the IAM Trust Policy:
   - `aud` MUST match `sts.amazonaws.com`.
   - `sub` MUST match `repo:<YOUR_GITHUB_ORG>/<YOUR_REPO>:ref:refs/heads/main`.
4. AWS STS issues temporary credentials valid for **1 hour**. No static secrets ever exist.

## 2. Kubernetes Pod Hardening
The application container runs under an enterprise-grade `securityContext`:
- `runAsNonRoot: true`: Container cannot run as UID 0.
- `runAsUser: 10001`: Explicit unprivileged UID.
- `readOnlyRootFilesystem: true`: Prevents attackers from writing malicious binaries to the container root filesystem.
- `allowPrivilegeEscalation: false`: Blocks setuid privilege escalation exploits.
- `capabilities.drop: ["ALL"]`: Drops all default Linux kernel capabilities.

## 3. Network Isolation
- Worker nodes and application pods run exclusively inside **Private Subnets**.
- No public IPv4 addresses are assigned to worker EC2 instances.
- Inbound cluster access is restricted to the EKS security group.