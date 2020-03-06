variable "name" {
  description = "The resource name"
  type        = string
}

variable "namespace" {
  description = "The resource namespace"
  type        = string
}

variable "replicas" {
  description = "The replica count"
  default     = 1
  type        = number
}

variable "ip_address" {
  description = "The ingress IP address"
  type        = string
}

variable "resource_group_name" {
  description = "The network resource group name"
  type        = string
}

variable "image" {
  description = "The docker image name"
  default     = "traefik:v1.7"
  type        = string
}

variable "class" {
  description = "The ingress class"
  default     = "traefik"
  type        = string
}

variable "metrics" {
  description = "Enable prometheus metrics"
  default     = false
  type        = bool
}
