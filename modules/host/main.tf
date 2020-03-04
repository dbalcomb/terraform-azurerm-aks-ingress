locals {
  name = trimsuffix(replace(var.name, var.zone.name, ""), ".")
}

data "azurerm_public_ip" "main" {
  name                = var.ip_address.name
  resource_group_name = var.ip_address.group
}

data "azurerm_dns_zone" "main" {
  name                = var.zone.name
  resource_group_name = var.zone.group
}

resource "azurerm_dns_a_record" "main" {
  name                = local.name == "" ? "@" : local.name
  zone_name           = data.azurerm_dns_zone.main.name
  resource_group_name = data.azurerm_dns_zone.main.resource_group_name
  target_resource_id  = data.azurerm_public_ip.main.id
  ttl                 = 300
}
