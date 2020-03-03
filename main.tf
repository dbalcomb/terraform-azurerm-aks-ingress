module "ip_address" {
  source = "./modules/ip-address"

  name                 = var.ip_address_name
  region               = var.ip_address_region
  service_principal_id = var.cluster_service_principal_id
}

module "controller" {
  source = "./modules/controller"

  name                = var.controller_name
  replicas            = var.controller_replicas
  ip_address          = module.ip_address.ip_address
  resource_group_name = module.ip_address.resource_group_name
  image               = var.controller_image
  class               = var.class
  metrics             = var.controller_metrics
}
