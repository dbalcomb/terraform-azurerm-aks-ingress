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

variable "configs" {
  description = "The config volume mount configuration"
  default     = {}
  type        = any
}

variable "secrets" {
  description = "The secret volume mount configuration"
  default     = {}
  type        = any
}

variable "files" {
  description = "The file share volume mount configuration"
  default     = {}
  type        = any
}
