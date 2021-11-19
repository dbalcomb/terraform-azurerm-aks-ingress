resource "azurerm_resource_group" "main" {
  name     = format("%s-rg", var.name)
  location = var.region

  tags = {
    provisioner = "terraform"
  }
}

resource "azurerm_role_assignment" "main" {
  principal_id         = var.cluster.service_principal.id
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Network Contributor"
}

resource "kubernetes_namespace" "main" {
  metadata {
    name = var.name
  }
}

module "ip_address" {
  source = "./modules/ip-address"

  name   = format("%s-ip", var.name)
  group  = azurerm_resource_group.main.name
  region = azurerm_resource_group.main.location
}

module "controller" {
  source = "./modules/controller"

  name       = var.name
  namespace  = kubernetes_namespace.main.metadata.0.name
  replicas   = var.replicas
  class      = var.class
  metrics    = var.metrics
  ip_address = module.ip_address
}
