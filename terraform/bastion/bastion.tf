locals {
  bastion_name     = "${var.project_name}-${var.environment}-bastion"
  bastion_eip_name = "${var.project_name}-${var.environment}-bastion-eip"

  bastion_tags = merge(var.tags, {
    Name = local.bastion_name
  })
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  key_name                    = var.key_pair_name
  iam_instance_profile        = aws_iam_instance_profile.bastion.name
  associate_public_ip_address = true

  user_data = templatefile("${path.module}/user-data.sh.tpl", {
    hostname = local.bastion_name
  })

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
    volume_size = var.root_volume_size
  }

  tags = local.bastion_tags

  lifecycle {
    precondition {
      condition     = !var.enable_ssh_ingress || var.key_pair_name != ""
      error_message = "Set a key_pair_name before enabling SSH access."
    }
  }
}

resource "aws_eip" "bastion" {
  count  = var.associate_elastic_ip ? 1 : 0
  domain = "vpc"

  tags = merge(var.tags, {
    Name = local.bastion_eip_name
  })
}

resource "aws_eip_association" "bastion" {
  count = var.associate_elastic_ip ? 1 : 0

  instance_id   = aws_instance.bastion.id
  allocation_id = aws_eip.bastion[0].id
}
