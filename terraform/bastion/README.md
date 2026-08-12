# DevBoard Bastion Server

This folder creates a simple AWS bastion host for the DevBoard project.

## What it creates

- One VPC
- One public subnet
- Internet gateway and route table
- One security group
- One EC2 bastion instance
- IAM role and instance profile
- Optional SSH access and SSM access
- Optional Elastic IP

## Before you run it

Make sure you have:

- AWS CLI installed and configured
- Terraform installed
- An existing EC2 key pair in your AWS region
- Your public IP or a valid CIDR for `bastion_allowed_ssh_cidr`

## Setup

```powershell
cd terraform\bastion
copy terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

Example values:

```hcl
aws_region               = "us-west-2"
project_name             = "devboard"
environment              = "hackathon"
instance_type            = "t3.small"
key_pair_name            = "devboard-bastion"
bastion_allowed_ssh_cidr = "203.0.113.10/32"
enable_ssh_ingress       = true
enable_ssm               = true
associate_elastic_ip     = false
root_volume_size         = 30
```

## Commands

```powershell
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

## Clean up

```powershell
terraform destroy
```

> Do not commit your `terraform.tfvars` file, state files, private keys, or plan files.
