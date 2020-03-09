# Controller

This module configures an ingress controller for the Azure Kubernetes Service
(AKS) cluster. The ingress controller is responsible for routing external
traffic through the cluster to the appropriate backend service.

## Usage

```hcl
module "controller" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/controller"

  name      = "aks-ingress-controller"
  namespace = "aks-ingress"
  replicas  = 3

  ip_address = {
    group = "aks-ingress-rg"
    value = "93.184.216.34"
  }
}
```

## Inputs

| Name               | Type     | Default        | Description                          |
| ------------------ | -------- | -------------- | ------------------------------------ |
| `name`             | `string` |                | The ingress controller name          |
| `namespace`        | `string` |                | The ingress controller namespace     |
| `replicas`         | `number` | `1`            | The ingress controller replica count |
| `image`            | `string` | `traefik:v1.7` | The ingress controller docker image  |
| `class`            | `string` | `traefik`      | The ingress class                    |
| `metrics`          | `bool`   | `false`        | Enable prometheus metrics            |
| `ip_address`       | `object` |                | The ingress IP address configuration |
| `ip_address.group` | `string` |                | The ingress IP address group         |
| `ip_address.value` | `string` |                | The ingress IP address value         |

## Outputs

| Name        | Type     | Description                          |
| ----------- | -------- | ------------------------------------ |
| `name`      | `string` | The ingress controller name          |
| `namespace` | `string` | The ingress controller namespace     |
| `replicas`  | `number` | The ingress controller replica count |
| `image`     | `string` | The ingress controller docker image  |
| `class`     | `string` | The ingress class                    |
| `metrics`   | `bool`   | Enable prometheus metrics            |
| `ip_address | `object` | The ingress IP address configuration |

## Notes

- The IP address must be unique to this ingress controller as Kubernetes does
  not currently allow IP addresses to be shared across services.

## References

- [Traefik Documentation](https://docs.traefik.io/v1.7/)
- [AKS Ingress Controller](https://docs.microsoft.com/en-gb/azure/aks/ingress-basic)
- [AKS Ingress Controller With Static IP](https://docs.microsoft.com/en-gb/azure/aks/ingress-static-ip)
- [AKS Load Balancer With Static IP](https://docs.microsoft.com/en-gb/azure/aks/static-ip)
