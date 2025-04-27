variable "key_name" {
  description = "Name of SSH to Access The Instance"
  default     = "atlantis-key"
}

variable "aws_region" {
  description = "AWS  region where all services will be provisioned"
  type        = string
}