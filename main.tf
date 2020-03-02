module "controller" {
  source = "./modules/controller"

  name                = var.controller_name
  replicas            = var.controller_replicas
  ip_address          = var.controller_ip_address
  resource_group_name = var.controller_resource_group_name
  image               = var.controller_image
  metrics             = var.controller_metrics
}
