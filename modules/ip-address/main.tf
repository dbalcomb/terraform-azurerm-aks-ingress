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
