output "name" {
  description = "The resource name"
  value       = helm_release.main.metadata.0.name
}

output "metrics" {
  description = "Enable prometheus metrics"
  value       = var.metrics
}
