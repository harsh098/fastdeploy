locals {
  name = "bastion-sg-${var.vpc_name}"
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["ssh-tcp"]
  egress_rules  = ["all-all"]
  description   = "Security group for SSH access to bastion host"
  default_tags = {
    name        = local.name
  }

  tags = var.tags != null? merge(var.tags, local.default_tags) : local.default_tags
}