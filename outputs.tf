output "name" {
  description = "The ingress name"
  value       = var.name
}

output "region" {
  description = "The ingress region"
  value       = var.region
}

output "replicas" {
  description = "The ingress replica count"
  value       = var.replicas
}

output "class" {
  description = "The ingress class"
  value       = var.class
}

output "metrics" {
  description = "Enable prometheus metrics"
  value       = var.metrics
}

output "cluster" {
  description = "The cluster configuration"
  value       = var.cluster
}

output "controller" {
  description = "The controller configuration"
  value       = module.controller
}

output "ip_address" {
  description = "The IP address configuration"
  value       = module.ip_address
}
