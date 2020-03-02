# Controller

This module configures an ingress controller for the Azure Kubernetes Service
(AKS) cluster. The ingress controller is responsible for routing external
traffic through the cluster to the appropriate backend service.

## Usage

```hcl
module "controller" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/controller"

  name                = "aks-ingress"
  replicas            = 3
  ip_address          = "93.184.216.34"
  resource_group_name = "aks-network-rg"
}
```

## Inputs

| Name                | Type   | Default      | Description                     |
| ------------------- | ------ | ------------ | ------------------------------- |
| name                | string |              | The resource name               |
| replicas            | number | 1            | The replica count               |
| ip_address          | string |              | The ingress IP address          |
| resource_group_name | string |              | The network resource group name |
| image               | string | traefik:v1.7 | The docker image name           |

## Outputs

| Name                | Type   | Description                     |
| ------------------- | ------ | ------------------------------- |
| name                | string | The resource name               |
| replicas            | number | The replica count               |
| ip_address          | string | The ingress IP address          |
| resource_group_name | string | The network resource group name |
| image               | string | The docker image name           |

## Notes

- The IP address must correspond to a Public IP resource in the given resource
  group in order for the Azure Kubernetes Service to accept it.

## References

- [Traefik Documentation](https://docs.traefik.io/v1.7/)
- [AKS Ingress Controller](https://docs.microsoft.com/en-gb/azure/aks/ingress-basic)
- [AKS Ingress Controller With Static IP](https://docs.microsoft.com/en-gb/azure/aks/ingress-static-ip)
- [AKS Load Balancer With Static IP](https://docs.microsoft.com/en-gb/azure/aks/static-ip)
