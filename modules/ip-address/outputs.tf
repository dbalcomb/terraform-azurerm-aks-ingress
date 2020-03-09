output "id" {
  description = "The IP address ID"
  value       = azurerm_public_ip.main.id
}

output "name" {
  description = "The IP address name"
  value       = azurerm_public_ip.main.name
}

output "group" {
  description = "The IP address group"
  value       = azurerm_public_ip.main.resource_group_name
}

output "region" {
  description = "The IP address region"
  value       = azurerm_public_ip.main.location
}

output "value" {
  description = "The IP address value"
  value       = azurerm_public_ip.main.ip_address
}
