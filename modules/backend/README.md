# Backend

This module configures an ingress backend for the Azure Kubernetes Service (AKS)
cluster. The backend is responsible for running a web application that responds
to requests routed via the ingress controller.

## Usage

```hcl
module "backend" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/backend"

  name     = "aks-backend"
  image    = "nginx:latest"
  replicas = 3
}
```

## Inputs

| Name     | Type   | Default | Description           |
| -------- | ------ | ------- | --------------------- |
| name     | string |         | The backend name      |
| image    | string |         | The docker image name |
| replicas | number | 1       | The replica count     |

## Outputs

| Name     | Type   | Description           |
| -------- | ------ | --------------------- |
| name     | string | The backend name      |
| image    | string | The docker image name |
| replicas | number | The replica count     |
