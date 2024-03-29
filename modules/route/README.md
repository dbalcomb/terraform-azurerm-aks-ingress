# Route

This module configures an ingress route for the Azure Kubernetes Service (AKS)
cluster that maps incoming requests to backend services.

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

module "host" {
  source = "github.com/dbalcomb/terraform-azurerm-dns//modules/host"

  # ...
}

module "issuer" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-cert-manager//modules/issuer"

  # ...
}

module "route" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/route"

  name    = "aks-route"
  path    = "/"
  host    = module.host
  backend = module.backend
  ingress = module.ingress
  issuer  = module.issuer
}
```

## Inputs

| Name                | Type                | Default | Description               |
| ------------------- | ------------------- | ------- | ------------------------- |
| `name`              | `string`            |         | The route name            |
| `path`              | `string`            | `/`     | The route path            |
| `host`              | `string` / `object` | `null`  | The host configuration    |
| `host.name`         | `string`            |         | The host name             |
| `hosts`             | `list`              | `[]`    | The hosts configuration   |
| `hosts.*`           | `string` / `object` |         | The host configuration    |
| `hosts.*.name`      | `string`            |         | The host name             |
| `backend`           | `object`            |         | The backend configuration |
| `backend.name`      | `string`            |         | The backend name          |
| `backend.namespace` | `string`            |         | The backend namespace     |
| `backend.port`      | `number`            |         | The backend port          |
| `ingress`           | `object`            |         | The ingress configuration |
| `ingress.class`     | `string`            |         | The ingress class         |
| `issuer`            | `object`            | `null`  | The issuer configuration  |
| `issuer.name`       | `string`            |         | The issuer name           |

## Outputs

| Name      | Type     | Description               |
| --------- | -------- | ------------------------- |
| `name`    | `string` | The route name            |
| `path`    | `string` | The route path            |
| `hosts`   | `list`   | The hosts configuration   |
| `hosts.*` | `string` | The host name             |
| `backend` | `object` | The backend configuration |
| `ingress` | `object` | The ingress configuration |
| `issuer`  | `object` | The issuer configuration  |
