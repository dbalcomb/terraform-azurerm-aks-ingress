output "name" {
  description = "The backend name"
  value       = kubernetes_service.main.metadata.0.name
}

output "namespace" {
  description = "The backend namespace"
  value       = local.namespace
}

output "port" {
  description = "The backend port"
  value       = 80
}

output "image" {
  description = "The docker image name"
  value       = var.image
}

output "replicas" {
  description = "The replica count"
  value       = var.replicas
}

output "configs" {
  description = "The config volume mount configuration"
  value       = local.configs
}

output "secrets" {
  description = "The secret volume mount configuration"
  value       = local.secrets
}

output "files" {
  description = "The file share volume mount configuration"
  value       = local.files
  sensitive   = true
}

output "env" {
  description = "The environment variables"
  value       = var.env
  sensitive   = true
}
