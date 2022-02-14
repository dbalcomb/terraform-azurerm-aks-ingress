resource "kubernetes_namespace" "main" {
  count = var.namespace == null ? 1 : 0

  metadata {
    name = var.name
  }
}

locals {
  namespace = var.namespace == null ? kubernetes_namespace.main.0.metadata.0.name : var.namespace
}

module "backend" {
  source = "../backend"

  name      = format("%s-backend", var.name)
  namespace = local.namespace
  image     = "adamkdean/redirect:1.2.5"
  replicas  = 2

  env = {
    "REDIRECT_LOCATION"    = var.location
    "REDIRECT_STATUS_CODE" = var.status_code
    "PRESERVE_URL"         = var.preserve_path ? "true" : "false"
  }
}

module "route" {
  source = "../route"

  name    = format("%s-route", var.name)
  path    = var.path
  host    = var.host
  hosts   = var.hosts
  backend = module.backend
  ingress = var.ingress
  issuer  = var.issuer
}
