output "name" {
  description = "The resource name"
  value       = helm_release.main.metadata.0.name
}
