resource "azurerm_resource_group" "main" {
  name     = format("%s-rg", var.name)
  location = var.region

  tags = {
    provisioner = "terraform"
  }
}

resource "azurerm_public_ip" "main" {
  name                = format("%s-ip", var.name)
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = {
    provisioner = "terraform"
  }
}

resource "azurerm_role_assignment" "main" {
  principal_id         = var.service_principal_id
  scope                = azurerm_resource_group.main.id
  role_definition_name = "Network Contributor"
}
