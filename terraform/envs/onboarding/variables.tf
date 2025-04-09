
variable "services" {
  description = "Map of services and their environment-specific DNS records"
  type = map(object({
    environments = map(object({
      dns = list(object({
        type  = string
        name  = string
        value = string
        ttl   = number
        priority = optional(string, null)
      }))
    }))
  }))
}

variable "cloudflare_zone_id" {
  description = "Zone ID for Cloudflare DNS Records"
  type = string
}