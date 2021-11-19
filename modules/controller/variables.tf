variable "name" {
  description = "The ingress controller name"
  type        = string
}

variable "namespace" {
  description = "The ingress controller namespace"
  type        = string
}

variable "replicas" {
  description = "The ingress controller replica count"
  default     = 1
  type        = number
}

variable "class" {
  description = "The ingress class"
  default     = "nginx"
  type        = string
}

variable "metrics" {
  description = "Enable prometheus metrics"
  default     = false
  type        = bool
}

variable "ip_address" {
  description = "The ingress IP address configuration"
  type = object({
    group = string
    value = string
  })
}
