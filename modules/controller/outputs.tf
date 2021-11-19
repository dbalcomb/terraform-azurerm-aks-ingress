output "name" {
  description = "The ingress controller name"
  value       = var.name
}

output "namespace" {
  description = "The ingress controller namespace"
  value       = var.namespace
}

output "replicas" {
  description = "The ingress controller replica count"
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

output "ip_address" {
  description = "The ingress IP address configuration"
  value       = var.ip_address
}
