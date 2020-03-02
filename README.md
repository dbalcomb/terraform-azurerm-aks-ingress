# terraform-azurerm-aks-ingress

[Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-gb/services/kubernetes-service/)
Ingress Terraform Module.

## Usage

```hcl
module "aks_ingress" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress"

  controller_name                = "aks-ingress"
  controller_replicas            = 3
  controller_ip_address          = "93.184.216.34"
  controller_resource_group_name = "aks-network-rg"
}
```

## Inputs

| Name                           | Type   | Default      | Description                                        |
| ------------------------------ | ------ | ------------ | -------------------------------------------------- |
| controller_name                | string |              | The ingress controller resource name               |
| controller_replicas            | number | 1            | The ingress controller replica count               |
| controller_ip_address          | string |              | The ingress controller IP address                  |
| controller_resource_group_name | string |              | The ingress controller network resource group name |
| controller_image               | string | traefik:v1.7 | The ingress controller docker image name           |

## Outputs

| Name                           | Type   | Description                                        |
| ------------------------------ | ------ | -------------------------------------------------- |
| controller_name                | string | The ingress controller resource name               |
| controller_replicas            | number | The ingress controller replica count               |
| controller_ip_address          | string | The ingress controller IP address                  |
| controller_resource_group_name | string | The ingress controller network resource group name |
| controller_image               | string | The ingress controller docker image name           |

## Modules

- [Controller](modules/controller/README.md)
