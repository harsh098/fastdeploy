locals {
  flattened_dns_records = flatten([
    for service_name, service in var.services : [
      for env_name, env in service.environments : [
        for dns_record in env.dns : {
          service     = service_name
          environment = env_name
          record      = dns_record
        }
      ]
    ]
  ])
  zone_id = var.cloudflare_zone_id
}