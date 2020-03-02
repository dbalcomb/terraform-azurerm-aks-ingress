# terraform-azurerm-aks-ingress

[Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-gb/services/kubernetes-service/)
Ingress Terraform Module.

## Usage

```hcl
module "aks_ingress" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress"

  ip_address_name   = "aks-ingress"
  ip_address_region = "uksouth"

  controller_name     = "aks-ingress"
  controller_replicas = 3

  cluster_service_principal_id = "00000000-0000-0000-0000-000000000000"
}
```

## Inputs

| Name                         | Type   | Default      | Description                                  |
| ---------------------------- | ------ | ------------ | -------------------------------------------- |
| controller_name              | string |              | The ingress controller resource name         |
| controller_replicas          | number | 1            | The ingress controller replica count         |
| controller_image             | string | traefik:v1.7 | The ingress controller docker image name     |
| controller_metrics           | bool   | false        | Enable ingress controller prometheus metrics |
| ip_address_name              | string |              | The IP address resource name                 |
| ip_address_region            | string |              | The IP address resource location             |
| cluster_service_principal_id | string |              | The cluster service principal ID             |

## Outputs

| Name                           | Type   | Description                                  |
| ------------------------------ | ------ | -------------------------------------------- |
| controller_name                | string | The ingress controller resource name         |
| controller_replicas            | number | The ingress controller replica count         |
| controller_image               | string | The ingress controller docker image name     |
| controller_metrics             | bool   | Enable ingress controller prometheus metrics |
| ip_address_name                | string | The IP address resource name                 |
| ip_address_region              | string | The IP address resource location             |
| ip_address_ip_address          | string | The IP address value                         |
| ip_address_resource_group_name | string | The IP address resource group name           |
| cluster_service_principal_id   | string | The cluster service principal ID             |

## Modules

- [Controller](modules/controller/README.md)
- [IP Address](modules/ip-address/README.md)
