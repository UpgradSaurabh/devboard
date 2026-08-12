output "bastion_public_ip" {
  description = "Public IP of the Bastion."
  value       = aws_instance.bastion.public_ip
}

output "bastion_instance_id" {
  description = "Bastion EC2 instance ID."
  value       = aws_instance.bastion.id
}

output "bastion_ami_id" {
  description = "AMI ID used by the Bastion."
  value       = data.aws_ami.ubuntu.id
}

output "bastion_role_arn" {
  description = "IAM role ARN attached to the Bastion."
  value       = aws_iam_role.bastion.arn
}

output "ssh_command" {
  description = "SSH command for the Bastion."
  value       = "ssh -i <path-to-key.pem> ubuntu@${aws_instance.bastion.public_ip}"
}

output "ssm_command" {
  description = "SSM Session Manager command."
  value       = "aws ssm start-session --target ${aws_instance.bastion.id} --region ${var.aws_region}"
}
