variable "controller_name" {
  description = "The ingress controller resource name"
  type        = string
}

variable "controller_replicas" {
  description = "The ingress controller replica count"
  default     = 1
  type        = number
}

variable "controller_image" {
  description = "The ingress controller docker image name"
  default     = "traefik:v1.7"
  type        = string
}

variable "controller_metrics" {
  description = "Enable ingress controller prometheus metrics"
  default     = false
  type        = bool
}

variable "ip_address_name" {
  description = "The IP address resource name"
  type        = string
}

variable "ip_address_region" {
  description = "The IP address resource location"
  type        = string
}

variable "cluster_service_principal_id" {
  description = "The cluster service principal ID"
  type        = string
}

variable "class" {
  description = "The ingress class"
  default     = "traefik"
  type        = string
}
