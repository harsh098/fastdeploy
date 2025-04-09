

resource "cloudflare_dns_record" "service_record" {
  count = length(local.flattened_dns_records)
  name = local.flattened_dns_records[count.index].record.name
  ttl = local.flattened_dns_records[count.index].record.ttl
  type = local.flattened_dns_records[count.index].record.type
  zone_id = local.zone_id
  content = local.flattened_dns_records[count.index].record.value
  priority = local.flattened_dns_records[count.index].record.priority
#   tags = [ 
#     "service:${local.flattened_dns_records[count.index].service}",
#     "environment:${local.flattened_dns_records[count.index].environment}"
#    ]
}