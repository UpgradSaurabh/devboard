output "bucket_name" {
  description = "Name of the Terraform state S3 bucket."
  value       = aws_s3_bucket.terraform_state.id
}

output "backend_hcl" {
  description = "Backend configuration for the main Terraform configuration."

  value = <<-EOT
    bucket = "${aws_s3_bucket.terraform_state.id}"
    key    = "devboard/dora-sota-implementation/terraform.tfstate"
    region = "${var.region}"

    encrypt = true
    use_lockfile = true
  EOT
}
