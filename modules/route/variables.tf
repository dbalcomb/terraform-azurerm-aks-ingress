variable "name" {
  description = "The route name"
  type        = string
}

variable "path" {
  description = "The route path"
  default     = "/"
  type        = string
}

variable "host" {
  description = "The host configuration"
  default     = null
  type        = any
}

variable "hosts" {
  description = "The hosts configuration"
  default     = []
  type        = list(any)
}

variable "backend" {
  description = "The backend configuration"
  type = object({
    name      = string
    namespace = string
    port      = number
  })
}

variable "ingress" {
  description = "The ingress configuration"
  type = object({
    class = string
  })
}

variable "issuer" {
  description = "The issuer configuration"
  default     = null
  type = object({
    name = string
  })
}
