variable "region" {
  description = "AWS region for the Terraform state bucket."
  type        = string
  default     = "us-west-2"
}

variable "bucket_name" {
  description = "Optional custom S3 bucket name."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Allow the bucket to be deleted even when it contains objects."
  type        = bool
  default     = true
}
