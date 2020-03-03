output "controller_name" {
  description = "The ingress controller resource name"
  value       = module.controller.name
}

output "controller_replicas" {
  description = "The ingress controller replica count"
  value       = module.controller.replicas
}

output "controller_image" {
  description = "The ingress controller docker image name"
  value       = module.controller.image
}

output "controller_metrics" {
  description = "Enable ingress controller prometheus metrics"
  value       = module.controller.metrics
}

output "ip_address_name" {
  description = "The IP address resource name"
  value       = module.controller.ip_address
}

output "ip_address_region" {
  description = "The IP address resource location"
  value       = module.controller.resource_group_name
}

output "ip_address_ip_address" {
  description = "The IP address value"
  value       = module.ip_address.ip_address
}

output "ip_address_resource_group_name" {
  description = "The IP address resource group name"
  value       = module.ip_address.resource_group_name
}

output "cluster_service_principal_id" {
  description = "The cluster service principal ID"
  value       = var.cluster_service_principal_id
}

output "class" {
  description = "The ingress class"
  value       = var.class
}
