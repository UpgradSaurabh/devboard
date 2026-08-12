$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$TerraformDir = Join-Path $Root "terraform\bastion"

Write-Host "Checking AWS authentication..."
aws sts get-caller-identity | Out-Host

Set-Location $TerraformDir

if (-not (Test-Path "terraform.tfvars")) {
    $PublicIp = (Invoke-RestMethod "https://checkip.amazonaws.com").Trim()
    @"
aws_region               = "us-west-2"
project_name             = "devboard"
environment              = "hackathon"
instance_type            = "t3.small"
ubuntu_version           = "24.04"
key_pair_name            = "devboard-bastion"
bastion_allowed_ssh_cidr = "$PublicIp/32"
enable_ssh_ingress       = true
enable_ssm               = true
associate_elastic_ip     = false
root_volume_size         = 30
"@ | Set-Content "terraform.tfvars"
    Write-Host "Created terraform.tfvars with detected public IP."
}

terraform fmt -recursive
terraform init
terraform validate
terraform plan
