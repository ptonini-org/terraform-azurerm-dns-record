output "this" {
  value = try(
    azurerm_dns_a_record.this[0],
    azurerm_dns_caa_record.this[0],
    azurerm_dns_cname_record.this[0],
    azurerm_dns_mx_record.this[0],
    azurerm_dns_txt_record.this[0]
  )
}