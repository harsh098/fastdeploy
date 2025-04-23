locals {
  name = "atlantis-${var.vpc_name}"
  ingress_cidr_blocks = var.ingress_cidr_blocks
  ingress_rules = concat(["ssh-tcp"], var.enable_http_80 ? ["http-80-tcp"]: [], var.enable_https_443 ? ["https-443-tcp"]: [])
  egress_rules  = ["all-all"]
  description   = "Security group with HTTPS traffic enabled from public"
  default_tags = {
    name        = local.name
  }
  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
  tags = var.tags != null? merge(var.tags, local.default_tags) : local.default_tags
}