output "name" {
  description = "The redirect name"
  value       = var.name
}

output "namespace" {
  description = "The redirect namespace"
  value       = module.backend.namespace
}

output "path" {
  description = "The redirect path"
  value       = module.route.path
}

output "hosts" {
  description = "The hosts configuration"
  value       = module.route.hosts
}

output "location" {
  description = "The redirect location"
  value       = var.location
}

output "status_code" {
  description = "The redirect status code"
  value       = var.status_code
}

output "preserve_path" {
  description = "Preserves the path"
  value       = var.preserve_path
}

output "ingress" {
  description = "The ingress configuration"
  value       = module.route.ingress
}

output "issuer" {
  description = "The issuer configuration"
  value       = module.route.issuer
}
