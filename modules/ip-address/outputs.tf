output "name" {
  description = "The resource name"
  value       = var.name
}

output "region" {
  description = "The resource location"
  value       = var.region
}

output "service_principal_id" {
  description = "The cluster service principal ID"
  value       = var.service_principal_id
}

output "ip_address" {
  description = "The ingress IP address"
  value       = azurerm_public_ip.main.ip_address
}

output "resource_group_name" {
  description = "The resource group name"
  value       = azurerm_resource_group.main.name
}