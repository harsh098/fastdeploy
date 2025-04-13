locals {
  name                 = var.vpc_name
  region               = var.aws_region
  environment          = var.environment != "" ? var.environment : "dev"  # Set default value to "dev" if not provided
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  nat_gateway_count    = contains(["stage", "production"], local.environment) ? 3 : 1

  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  private_subnet_prefix = var.private_subnet_prefix
  public_subnet_prefix  = var.public_subnet_prefix
  tags = {
    Environment = local.environment
  }
}