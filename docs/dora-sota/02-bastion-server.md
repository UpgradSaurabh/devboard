# Phase 1 — AWS Bastion Server

## Objective

Create a secure AWS Bastion / Jump Server that will act as the central DevOps management server for later phases.

The Bastion will later be used for Terraform, Ansible, AWS CLI, kubectl, Helm, Docker and Git.

## Prerequisites

- AWS CLI installed on Windows
- `aws configure` completed
- `aws sts get-caller-identity` working
- Terraform installed
- AWS region: `us-west-2`
- EC2 key pair: `devboard-bastion`

## What We Create

Terraform creates:

- Dedicated VPC: `10.10.0.0/16`
- Public subnet: `10.10.1.0/24`
- Internet Gateway
- Public route table
- Bastion Security Group
- IAM role + instance profile
- SSM access
- Ubuntu 24.04 EC2
- Encrypted gp3 root volume
- IMDSv2

SSH is restricted to the configured public IP `/32`.

## Important

The Bastion is a management server. It is not the EKS cluster and does not host the application.

EKS, GitOps, progressive delivery, policy-as-code, supply-chain security and DORA dashboard work will be implemented in later phases.

## Commands

```powershell
cd terraform\bastion
copy terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars

terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Validation

After creation:

```bash
aws sts get-caller-identity
```

Then connect to the Bastion using SSH or SSM.

## Files Added

- `terraform/bastion/` Terraform configuration
- `scripts/bastion-terraform-plan.ps1`
- `docs/dora-sota/02-bastion-server.md`

## Security Notes

- Do not allow SSH from `0.0.0.0/0`.
- Do not commit AWS credentials, private keys, `terraform.tfvars` or Terraform state.
- IAM permissions are intentionally broad for the hackathon/lab and should be narrowed before production use.

## Cleanup

```powershell
terraform destroy
```
