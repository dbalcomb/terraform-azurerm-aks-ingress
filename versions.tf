terraform {
  required_version = ">= 0.12"

  required_providers {
    azurerm    = ">= 1.42, < 2.0"
    kubernetes = ">= 1.10"
  }
}
