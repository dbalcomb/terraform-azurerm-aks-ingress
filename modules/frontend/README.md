# Frontend

This module configures an ingress frontend for the Azure Kubernetes Service
(AKS) cluster. The frontend is responsible for mapping ingress routes to backend
services.

## Usage

```hcl
module "ingress" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress"

  # ...
}

module "backend" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/backend"

  # ...
}

module "frontend" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/frontend"

  name  = "aks-frontend"
  class = module.ingress.class

  routes = {
    one = {
      host = "example.com"
      path = "/one"

      backend = {
        name      = "aks-backend1"
        namespace = "aks-backend1"
        port      = 80
      }
    }

    two = {
      host    = "example.com"
      path    = "/two"
      backend = module.backend
    }
  }
}
```

## Inputs

| Name   | Type   | Default | Description             |
| ------ | ------ | ------- | ----------------------- |
| name   | string |         | The frontend name       |
| routes | object |         | The route configuration |
| class  | string | traefik | The ingress class       |

## Outputs

| Name   | Type   | Description             |
| ------ | ------ | ----------------------- |
| name   | string | The frontend name       |
| routes | object | The route configuration |
| class  | string | The ingress class       |
