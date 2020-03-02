# IP Address

This module configures the ingress IP address for the Azure Kubernetes Service
(AKS) cluster. This configuration can then be sent to the ingress controller to
handle load balancing and routing.

## Usage

```hcl
module "ip_address" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/ip-address"

  name                 = "aks-ingress"
  region               = "uksouth"
  service_principal_id = "00000000-0000-0000-0000-000000000000"
}
```

## Inputs

| Name                 | Type   | Default | Description                      |
| -------------------- | ------ | ------- | -------------------------------- |
| name                 | string |         | The resource name                |
| region               | string |         | The resource location            |
| service_principal_id | string |         | The cluster service principal ID |

## Outputs

| Name                 | Type   | Description                      |
| -------------------- | ------ | -------------------------------- |
| name                 | string | The resource name                |
| region               | string | The resource location            |
| service_principal_id | string | The cluster service principal ID |
| ip_address           | string | The ingress IP address           |
| resource_group_name  | string | The resource group name          |
