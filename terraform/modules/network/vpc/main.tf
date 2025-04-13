module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.1"

  name        = format("${var.vpc_name}-%s-vpc", var.environment)
  cidr        = var.vpc_cidr
  azs         = local.azs
  
  enable_nat_gateway   = local.private_subnet_count > 0 ? true: false
  single_nat_gateway   = false
  one_nat_gateway_per_az = false
  enable_dns_hostnames = true
  enable_dns_support   = true

  private_subnet_names = [for idx in range(local.private_subnet_count) : "${var.environment}-private-${idx + 1}"]
  public_subnet_names  = [for idx in range(local.public_subnet_count) : "${var.environment}-public-${idx + 1}"]

  private_subnets = [for idx in range(local.private_subnet_count) : cidrsubnet(var.vpc_cidr, 8, idx)]
  public_subnets  = [for idx in range(local.public_subnet_count) : cidrsubnet(var.vpc_cidr, 8, idx + local.private_subnet_count)]

  manage_default_network_acl    = false
  manage_default_route_table    = false
  manage_default_security_group = false

  private_subnet_tags              = {
    "kubernetes.io/role/internal-elb" = "1"
  }
  public_subnet_tags               = {
    "kubernetes.io/role/elb" = "1"
  }
  tags = local.tags
}