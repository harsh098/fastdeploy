terraform {
  backend "s3" {
    bucket = "hmx-terraform-bucket"
    region = "ap-south-1"
    key    = "atlantis/terraform.tfstate"
  }
  required_providers {
    aws = "5.95.0"
  }
}

provider "aws" {
  region = var.aws_region
}