# Redirect

This module configures an ingress redirect for the Azure Kubernetes Service
(AKS) cluster that redirects incoming requests to the specified location.

## Usage

```hcl
module "ingress" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress"

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

module "redirect" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/redirect"

  name        = "aks-redirect"
  path        = "/"
  host        = module.host
  location    = "https://www.example.com"
  status_code = 307
  ingress     = module.ingress
  issuer      = module.issuer
}
```

## Inputs

| Name            | Type                | Default | Description               |
| --------------- | ------------------- | ------- | ------------------------- |
| `name`          | `string`            |         | The redirect name         |
| `namespace`     | `string`            | `null`  | The redirect namespace    |
| `path`          | `string`            | `/`     | The redirect path         |
| `host`          | `string` / `object` | `null`  | The host configuration    |
| `host.name`     | `string`            |         | The host name             |
| `hosts`         | `list`              | `[]`    | The hosts configuration   |
| `hosts.*`       | `string` / `object` |         | The host configuration    |
| `hosts.*.name`  | `string`            |         | The host name             |
| `location`      | `string`            |         | The redirect location     |
| `status_code`   | `number`            | `301`   | The redirect status code  |
| `preserve_path` | `bool`              | `false` | Preserves the path        |
| `ingress`       | `object`            |         | The ingress configuration |
| `ingress.class` | `string`            |         | The ingress class         |
| `issuer`        | `object`            | `null`  | The issuer configuration  |
| `issuer.name`   | `string`            |         | The issuer name           |

## Outputs

| Name            | Type     | Description               |
| --------------- | -------- | ------------------------- |
| `name`          | `string` | The redirect name         |
| `namespace`     | `string` | The redirect namespace    |
| `path`          | `string` | The redirect path         |
| `hosts`         | `list`   | The hosts configuration   |
| `location`      | `string` | The redirect location     |
| `status_code`   | `list`   | The redirect status code  |
| `preserve_path` | `bool`   | Preserves the path        |
| `ingress`       | `object` | The ingress configuration |
| `issuer`        | `object` | The issuer configuration  |
