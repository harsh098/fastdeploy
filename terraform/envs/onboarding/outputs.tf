output "services_dns_map" {
  value = local.flattened_dns_records
}

output "service_envs" {
  value = local.service_envs
}