variable "name" {
  description = "The ingress name"
  type        = string
}

variable "region" {
  description = "The ingress region"
  type        = string
}

variable "replicas" {
  description = "The ingress replica count"
  default     = 1
  type        = number
}

variable "image" {
  description = "The ingress docker image"
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

variable "cluster" {
  description = "The cluster configuration"
  type = object({
    service_principal = object({
      id = string
    })
  })
}
