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

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules"
  type = list(string)
  default = [ "0.0.0.0/0" ]
}

variable "ingress_with_cidr_blocks" {
  description = "List of computed ingress rules to create where 'cidr_blocks' is used"
  type = list(map(string))
  default = []
}

variable "enable_http_80" {
  description = "Enable Insecure HTTP Traffic on Port 80"
  type = bool
  default = true
}

variable "enable_https_443" {
  description = "Enable HTTPS Traffic on Port 80"
  type = bool
  default = false
}