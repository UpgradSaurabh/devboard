locals {
  security_group_name = "${var.project_name}-${var.environment}-bastion-sg"
}

resource "aws_security_group" "bastion" {
  name        = local.security_group_name
  description = "Security group for the DevBoard bastion host"
  vpc_id      = aws_vpc.bastion.id

  tags = merge(var.tags, {
    Name = local.security_group_name
  })
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  count = var.enable_ssh_ingress ? 1 : 0

  security_group_id = aws_security_group.bastion.id
  cidr_ipv4         = var.bastion_allowed_ssh_cidr
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
