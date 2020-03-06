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
| `name`   | `string` |         | The resource name     |
| `group`  | `string` |         | The resource group    |
| `region` | `string` |         | The resource location |

## Outputs

| Name         | Type     | Description            |
| ------------ | -------- | ---------------------- |
| `name`       | `string` | The resource name      |
| `group`      | `string` | The resource group     |
| `region`     | `string` | The resource location  |
| `ip_address` | `string` | The ingress IP address |
