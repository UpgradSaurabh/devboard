locals {
  bastion_role_name    = "${var.project_name}-${var.environment}-bastion-role"
  bastion_profile_name = "${var.project_name}-${var.environment}-bastion-profile"
  bastion_policy_name  = "bastion-terraform"
}

resource "aws_iam_role" "bastion" {
  name = local.bastion_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# This is intentionally broad for a lab or hackathon environment.
# In a real production setup, scope this down to the exact AWS resources you need.
resource "aws_iam_role_policy" "bastion_terraform" {
  name = local.bastion_policy_name
  role = aws_iam_role.bastion.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "ec2:*",
        "eks:*",
        "iam:*",
        "elasticloadbalancing:*",
        "s3:*",
        "logs:*",
        "autoscaling:*",
        "secretsmanager:*",
        "kms:*"
      ]
      Resource = "*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm" {
  count      = var.enable_ssm ? 1 : 0
  role       = aws_iam_role.bastion.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "bastion" {
  name = local.bastion_profile_name
  role = aws_iam_role.bastion.name
}
