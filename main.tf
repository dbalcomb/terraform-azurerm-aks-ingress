module "ip_address" {
  source = "./modules/ip-address"

  name   = var.ip_address_name
  region = var.ip_address_region
}

module "controller" {
  source = "./modules/controller"

  name                = var.controller_name
  replicas            = var.controller_replicas
  ip_address          = module.ip_address.ip_address
  resource_group_name = module.ip_address.resource_group_name
  image               = var.controller_image
  metrics             = var.controller_metrics
}
