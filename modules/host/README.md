# Host

This module configures an ingress host domain / subdomain that points to the
Azure Kubernetes Service (AKS) ingress. The route module can then use the
output to ensure that the DNS records are created first.

## Usage

```hcl
module "ingress" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress"

  # ...
}

module "host" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/host"

  name = "sub.example.com"

  zone = {
    name  = "example.com"
    group = "example-com-rg"
  }

  ip_address = {
    name  = "${module.ingress.ip_address_name}-ip"
    group = module.ingress.ip_address_resource_group_name
  }
}
```

## Inputs

| Name               | Type     | Default | Description                       |
| ------------------ | -------- | ------- | --------------------------------- |
| `name`             | `string` |         | The host name                     |
| `zone`             | `object` |         | The host zone                     |
| `zone.name`        | `string` |         | The host zone name                |
| `zone.group`       | `string` |         | The host zone resource group name |
| `ip_address`       | `object` |         | The ingress IP address            |
| `ip_address.name`  | `string` |         | The ingress IP address name       |
| `ip_address.group` | `string` |         | The ingress IP address group      |

## Outputs

| Name         | Type     | Default | Description            |
| ------------ | -------- | ------- | ---------------------- |
| `name`       | `string` |         | The host name          |
| `zone`       | `object` |         | The host zone          |
| `ip_address` | `object` |         | The ingress IP address |
