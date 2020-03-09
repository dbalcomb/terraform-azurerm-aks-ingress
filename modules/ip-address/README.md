# IP Address

This module configures the ingress IP address for the Azure Kubernetes Service
(AKS) cluster. This configuration can then be sent to the ingress controller to
handle load balancing and routing.

## Usage

```hcl
module "ip_address" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/ip-address"

  name   = "aks-ingress"
  group  = "aks-ingress-rg"
  region = "uksouth"
}
```

## Inputs

| Name     | Type     | Default | Description           |
| -------- | -------- | ------- | --------------------- |
| `name`   | `string` |         | The IP address name   |
| `group`  | `string` |         | The IP address group  |
| `region` | `string` |         | The IP address region |

## Outputs

| Name     | Type     | Description           |
| -------- | -------- | --------------------- |
| `id`     | `string` | The IP address ID     |
| `name`   | `string` | The IP address name   |
| `group`  | `string` | The IP address group  |
| `region` | `string` | The IP address region |
| `value`  | `string` | The IP address value  |
