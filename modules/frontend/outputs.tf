output "name" {
  description = "The frontend name"
  value       = var.name
}

output "routes" {
  description = "The route configuration"
  value       = var.routes
}

output "class" {
  description = "The ingress class"
  value       = var.class
}
