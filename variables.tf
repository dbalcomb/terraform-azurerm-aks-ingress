variable "controller_name" {
  description = "The ingress controller resource name"
  type        = string
}

variable "controller_replicas" {
  description = "The ingress controller replica count"
  default     = 1
  type        = number
}

variable "controller_ip_address" {
  description = "The ingress controller IP address"
  type        = string
}

variable "controller_resource_group_name" {
  description = "The ingress controller network resource group name"
  type        = string
}

variable "controller_image" {
  description = "The ingress controller docker image name"
  default     = "traefik:v1.7"
  type        = string
}
