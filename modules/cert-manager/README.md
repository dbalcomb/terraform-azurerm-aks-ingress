# Certificate Manager

This module configures the `cert-manager` utility to enable the management of
SSL certificates and the ability for the ingress controller to serve requests
via HTTPS.

## Usage

```hcl
module "cert_manager" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/cert-manager"

  name    = "aks-cert-manager"
  metrics = true
}
```

## Inputs

| Name      | Type     | Default        | Description               |
| --------- | -------- | -------------- | ------------------------- |
| `name`    | `string` | `cert-manager` | The resource name         |
| `metrics` | `bool`   | `false`        | Enable prometheus metrics |

## Outputs

| Name      | Type     | Description               |
| --------- | -------- | ------------------------- |
| `name`    | `string` | The resource name         |
| `metrics` | `bool`   | Enable prometheus metrics |

## Notes

- At this time there is no official Terraform provider capable of handling
  custom resource definitions for Kubernetes. This means that there is a
  dependency on a locally-installed Kubernetes CLI (`kubectl`) in order to
  deploy the required definitions.
- This module requires a `kubeconfig` file in the current working directory in
  order to authenticate with the Kubernetes CLI.

## References

- [AKS Ingress Controller](https://docs.microsoft.com/en-gb/azure/aks/ingress-static-ip)
- [Securing Ingress Routes](https://cert-manager.io/docs/tutorials/acme/ingress/)
