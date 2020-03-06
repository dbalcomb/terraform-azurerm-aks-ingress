resource "azurerm_public_ip" "main" {
  name                = format("%s-ip", var.name)
  resource_group_name = var.group
  location            = var.region
  sku                 = "Standard"
  allocation_method   = "Static"

  tags = {
    provisioner = "terraform"
  }
}
