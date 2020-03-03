variable "name" {
  description = "The resource name"
  default     = "cert-manager"
  type        = string
}

variable "metrics" {
  description = "Enable prometheus metrics"
  default     = false
  type        = bool
}
