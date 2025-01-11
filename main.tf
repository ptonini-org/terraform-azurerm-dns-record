resource "azurerm_dns_a_record" "this" {
  count               = var.type == "a" ? 1 : 0
  name                = var.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl
  records             = var.records
  target_resource_id  = var.target_resource_id

  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["environment"],
      tags["product"],
      tags["subscription_type"],
    ]
  }
}

resource "azurerm_dns_cname_record" "this" {
  count               = var.type == "cname" ? 1 : 0
  name                = var.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl
  record              = var.records[0]
  target_resource_id  = var.target_resource_id

  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["environment"],
      tags["product"],
      tags["subscription_type"],
    ]
  }
}

resource "azurerm_dns_txt_record" "this" {
  count               = var.type == "txt" ? 1 : 0
  name                = var.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl

  dynamic "record" {
    for_each = toset(var.records)

    content {
      value = record.key
    }
  }

  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["environment"],
      tags["product"],
      tags["subscription_type"],
    ]
  }
}

resource "azurerm_dns_mx_record" "this" {
  count               = var.type == "mx" ? 1 : 0
  name                = var.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl

  dynamic "record" {
    for_each = { for i, v in var.records : i => v }

    content {
      exchange   = record.value.exchange
      preference = record.value.preference
    }
  }

  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["environment"],
      tags["product"],
      tags["subscription_type"],
    ]
  }
}

resource "azurerm_dns_caa_record" "this" {
  count               = var.type == "caa" ? 1 : 0
  name                = var.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl

  dynamic "record" {
    for_each = { for i, v in var.records : i => v }

    content {
      flags = record.value.flags
      tag   = record.value.tag
      value = record.value.value
    }
  }

  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["environment"],
      tags["product"],
      tags["subscription_type"],
    ]
  }
}