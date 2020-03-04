variable "name" {
  description = "The host name"
  type        = string
}

variable "zone" {
  description = "The host zone"
  type = object({
    name  = string
    group = string
  })
}

variable "ip_address" {
  description = "The ingress IP address"
  type = object({
    name  = string
    group = string
  })
}
