output "name" {
  description = "The resource name"
  value       = var.name
}

output "group" {
  description = "The resource group"
  value       = var.group
}

output "region" {
  description = "The resource location"
  value       = var.region
}

output "ip_address" {
  description = "The ingress IP address"
  value       = azurerm_public_ip.main.ip_address
}
