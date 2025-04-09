
resource "cloudflare_dns_record" "service_record" {
  for_each = {
    for idx, item in local.flattened_dns_records :
    "${item.service}-${item.environment}-${item.record.name}-${idx}" => item
  }

  zone_id  = local.zone_id
  name     = each.value.record.name
  type     = each.value.record.type
  ttl      = each.value.record.ttl
  content  = each.value.record.value
  priority = each.value.record.priority

  # Optional: tag metadata
  # Free Tier is limited to 2 tags per DNS Zone.
  # So skipping the tags section
}
