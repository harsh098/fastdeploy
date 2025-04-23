variable "aws_region" {
  description = "AWS  region where all services will be provisioned"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_name" {
  description = "Name of AWS VPC"
  type        = string
}

variable "environment" {
  description = "Environment for which VPC is being created (dev, qa, staging, production)"
  type        = string

  validation {
    condition     = contains(["dev", "qa", "stage", "production", "onboarding", "atlantis"], var.environment)
    error_message = "Environment must be one of: dev, qa, stage, production, onboarding, atlantis"
  }
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  
}


variable "private_subnet" {
  description = "Prefix to be used for Private subnet name"
  type        = string
  default     = "Private"
}

variable "public_subnet" {
  description = "Prefix to be used for Private subnet name"
  type        = string
  default     = "Public"
}

variable "private_subnet_prefix" {
  description = "Prefix to be used for Private subnet name"
  type        = string
  default     = "Private"
}

variable "public_subnet_prefix" {
  description = "Prefix to be used for Public subnet name"
  type        = string
  default     = "Public"
}

variable "private_subnet_count" {
  description = "Number of Private Subnets"
  type = number
  default = 0
}

variable "public_subnet_count" {
  description = "Number of Public Subnets"
  type = number
  default = 1
}