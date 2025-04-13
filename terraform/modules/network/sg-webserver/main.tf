module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.name
  description = local.description
  vpc_id      = var.vpc_id

  ingress_cidr_blocks = local.ingress_cidr_blocks
  ingress_with_cidr_blocks = local.ingress_with_cidr_blocks
  ingress_rules       = local.ingress_rules
  egress_rules        = local.egress_rules

  tags = local.tags
}