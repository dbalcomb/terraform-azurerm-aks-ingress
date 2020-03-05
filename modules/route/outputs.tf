output "name" {
  description = "The route name"
  value       = var.name
}

output "path" {
  description = "The route path"
  value       = var.path
}

output "host" {
  description = "The host configuration"
  value       = var.host
}

output "backend" {
  description = "The backend configuration"
  value       = var.backend
}

output "ingress" {
  description = "The ingress configuration"
  value       = var.ingress
}
