resource "azurerm_resource_group" "main" {
  name     = format("%s-rg", var.ip_address_name)
  location = var.ip_address_region

  tags = {
    provisioner = "terraform"
  }
}

resource "azurerm_role_assignment" "main" {
  principal_id         = var.cluster_service_principal_id
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Network Contributor"
}

resource "kubernetes_namespace" "main" {
  metadata {
    name = var.controller_name
  }
}

module "ip_address" {
  source = "./modules/ip-address"

  name   = var.ip_address_name
  group  = azurerm_resource_group.main.name
  region = var.ip_address_region
}

module "controller" {
  source = "./modules/controller"

  name                = var.controller_name
  namespace           = kubernetes_namespace.main.metadata.0.name
  replicas            = var.controller_replicas
  ip_address          = module.ip_address.ip_address
  resource_group_name = azurerm_resource_group.main.name
  image               = var.controller_image
  class               = var.class
  metrics             = var.controller_metrics
}
