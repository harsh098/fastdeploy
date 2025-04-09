locals {
  # Flatten DNS records with null-safe access. 
  # This is because, 
  # Some services may be internal and not require DNS Settings
  # This can used to deploy system level components such as agents, system software etc.
  flattened_dns_records = flatten([
    for service_name, service in var.services : [
      for env_name, env in service.environments : [
        for record in lookup(env, "dns", []) : {
          service     = service_name
          environment = env_name
          record      = record
        }
      ]
    ]
  ])
  zone_id = var.cloudflare_zone_id
}
