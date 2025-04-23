locals {
  environment = "atlantis"
  region      = var.aws_region
  vpc_name    = "atlantis-${var.aws_region}"
}