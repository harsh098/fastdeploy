variable "region" {
  description = "AWS region to deploy our resources"
  type        = string
  default     = "us-west-2"
}

variable "vpc_id" {
  description = "vpc id for the sg"
  type        = string
}

variable "vpc_name" {
  description = "name of the vpc"
  type        = string
}

variable "tags" {
  description = "Tags to be applied"
  type = map(any)
  default = {}
}