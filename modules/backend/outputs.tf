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

output "volumes" {
  description = "The volume configuration"
  value       = var.volumes
}
