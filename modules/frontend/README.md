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

| Name                         | Type     | Default   | Description                 |
| ---------------------------- | -------- | --------- | --------------------------- |
| `name`                       | `string` |           | The frontend name           |
| `class`                      | `string` | `traefik` | The ingress class           |
| `routes`                     | `object` |           | The route configuration     |
| `routes.*.host`              | `string` |           | The route host              |
| `routes.*.path`              | `string` |           | The route path              |
| `routes.*.backend`           | `object` |           | The route backend           |
| `routes.*.backend.name`      | `string` |           | The route backend name      |
| `routes.*.backend.namespace` | `string` |           | The route backend namespace |
| `routes.*.backend.port`      | `number` |           | The route backend port      |

## Outputs

| Name     | Type     | Description             |
| -------- | -------- | ----------------------- |
| `name`   | `string` | The frontend name       |
| `class`  | `string` | The ingress class       |
| `routes` | `object` | The route configuration |
