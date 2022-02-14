variable "name" {
  description = "The redirect name"
  type        = string
}

variable "namespace" {
  description = "The redirect namespace"
  default     = null
  type        = string
}

variable "path" {
  description = "The redirect path"
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

variable "location" {
  description = "The redirect location"
  type        = string
}

variable "status_code" {
  description = "The redirect status code"
  default     = 301
  type        = number
}

variable "preserve_path" {
  description = "Preserves the path"
  default     = false
  type        = bool
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
