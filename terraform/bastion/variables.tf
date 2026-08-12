variable "aws_region" {
  description = "AWS region where the bastion will be created."
  type        = string
  default     = "us-west-2"
}

variable "project_name" {
  description = "Name used in resource names."
  type        = string
  default     = "devboard"
}

variable "environment" {
  description = "Environment name such as dev, staging, or prod."
  type        = string
  default     = "hackathon"
}

variable "instance_type" {
  description = "EC2 instance size for the bastion."
  type        = string
  default     = "t3.small"
}

variable "key_pair_name" {
  description = "Name of the existing EC2 key pair used to access the bastion."
  type        = string
  default     = "devboard-bastion"
}

variable "bastion_allowed_ssh_cidr" {
  description = "Public CIDR allowed to SSH into the bastion. Example: 203.0.113.10/32"
  type        = string

  validation {
    condition     = can(cidrhost(var.bastion_allowed_ssh_cidr, 0))
    error_message = "bastion_allowed_ssh_cidr must be a valid CIDR such as 203.0.113.10/32."
  }
}

variable "enable_ssh_ingress" {
  description = "Enable SSH access to the bastion."
  type        = bool
  default     = true
}

variable "enable_ssm" {
  description = "Attach the AWS Systems Manager policy to the bastion role."
  type        = bool
  default     = true
}

variable "associate_elastic_ip" {
  description = "Attach an Elastic IP to the bastion."
  type        = bool
  default     = false
}

variable "root_volume_size" {
  description = "Size of the bastion root volume in GiB."
  type        = number
  default     = 30
}

variable "vpc_cidr" {
  description = "CIDR block for the dedicated bastion VPC."
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
  default     = "10.10.1.0/24"
}

variable "tags" {
  description = "Default tags applied to all resources."
  type        = map(string)
  default = {
    Project   = "devboard"
    Component = "bastion"
    ManagedBy = "terraform"
  }
}
