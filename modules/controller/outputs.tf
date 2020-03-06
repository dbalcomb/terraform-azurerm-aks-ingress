output "name" {
  description = "The resource name"
  value       = var.name
}

output "namespace" {
  description = "The resource namespace"
  value       = var.namespace
}

output "replicas" {
  description = "The replica count"
  value       = var.replicas
}

output "ip_address" {
  description = "The ingress IP address"
  value       = var.ip_address
}

output "resource_group_name" {
  description = "The network resource group name"
  value       = var.resource_group_name
}

output "image" {
  description = "The docker image name"
  value       = var.image
}

output "class" {
  description = "The ingress class"
  value       = var.class
}

output "metrics" {
  description = "Enable prometheus metrics"
  value       = var.metrics
}
