variable "name" {
  description = "The backend name"
  type        = string
}

variable "namespace" {
  description = "The backend namespace"
  default     = null
  type        = string
}

variable "image" {
  description = "The docker image name"
  type        = string
}

variable "replicas" {
  description = "The replica count"
  default     = 1
  type        = number
}

variable "volumes" {
  description = "The volume configuration"
  default     = {}
  type        = any
}
