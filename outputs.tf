output "controller_name" {
  description = "The ingress controller resource name"
  value       = module.controller.name
}

output "controller_replicas" {
  description = "The ingress controller replica count"
  value       = module.controller.replicas
}

output "controller_ip_address" {
  description = "The ingress controller IP address"
  value       = module.controller.ip_address
}

output "controller_resource_group_name" {
  description = "The ingress controller network resource group name"
  value       = module.controller.resource_group_name
}

output "controller_image" {
  description = "The ingress controller docker image name"
  value       = module.controller.image
}

output "controller_metrics" {
  description = "Enable ingress controller prometheus metrics"
  value       = module.controller.metrics
}
