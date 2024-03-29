output "name" {
  description = "The route name"
  value       = var.name
}

output "path" {
  description = "The route path"
  value       = var.path
}

output "hosts" {
  description = "The hosts configuration"
  value       = local.hosts
}

output "backend" {
  description = "The backend configuration"
  value       = var.backend
}

output "ingress" {
  description = "The ingress configuration"
  value       = var.ingress
}

output "issuer" {
  description = "The issuer configuration"
  value       = var.issuer
}
