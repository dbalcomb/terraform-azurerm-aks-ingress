variable "name" {
  description = "The backend name"
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
