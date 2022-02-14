# terraform-azurerm-aks-ingress

[Azure Kubernetes Service (AKS)](https://azure.microsoft.com/en-gb/services/kubernetes-service/)
Ingress Terraform Module.

## Usage

```hcl
module "aks_ingress" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress"

  name     = "aks-ingress"
  region   = "uksouth"
  replicas = 3
  metrics  = true

  cluster = {
    service_principal = {
      id = "00000000-0000-0000-0000-000000000000"
    }
  }
}
```

## Inputs

| Name                           | Type     | Default | Description                                 |
| ------------------------------ | -------- | ------- | ------------------------------------------- |
| `name`                         | `string` |         | The ingress name                            |
| `region`                       | `string` |         | The ingress region                          |
| `replicas`                     | `number` | `1`     | The ingress replica count                   |
| `class`                        | `string` | `nginx` | The ingress class                           |
| `metrics`                      | `bool`   | `false` | Enable prometheus metrics                   |
| `cluster`                      | `object` |         | The cluster configuration                   |
| `cluster.service_principal`    | `object` |         | The cluster service principal configuration |
| `cluster.service_principal.id` | `string` |         | The cluster service principal ID            |

## Outputs

| Name         | Type     | Description                  |
| ------------ | -------- | ---------------------------- |
| `name`       | `string` | The ingress name             |
| `region`     | `string` | The ingress region           |
| `replicas`   | `number` | The ingress replica count    |
| `class`      | `string` | The ingress class            |
| `metrics`    | `bool`   | Enable prometheus metrics    |
| `cluster`    | `string` | The cluster configuration    |
| `controller` | `object` | The controller configuration |
| `ip_address` | `object` | The IP address configuration |

## Modules

- [Controller](modules/controller/README.md)
- [IP Address](modules/ip-address/README.md)
- [Backend](modules/backend/README.md)
- [Redirect](modules/redirect/README.md)
- [Route](modules/route/README.md)

## External Modules

- [Certificate Manager](https://github.com/dbalcomb/terraform-azurerm-aks-cert-manager)
- [DNS Zone](https://github.com/dbalcomb/terraform-azurerm-dns/tree/master/modules/zone)
- [DNS Host](https://github.com/dbalcomb/terraform-azurerm-dns/tree/master/modules/host)
