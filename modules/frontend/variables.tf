variable "name" {
  description = "The frontend name"
  type        = string
}

variable "routes" {
  description = "The route configuration"
  type = map(object({
    host = string
    path = string
    backend = object({
      name      = string
      namespace = string
      port      = number
    })
  }))
}
