output "name" {
  description = "The backend name"
  value       = var.name
}

output "image" {
  description = "The docker image name"
  value       = var.image
}

output "replicas" {
  description = "The replica count"
  value       = var.replicas
}
