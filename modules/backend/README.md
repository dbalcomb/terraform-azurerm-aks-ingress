# Backend

This module configures an ingress backend for the Azure Kubernetes Service (AKS)
cluster. The backend is responsible for running a web application that responds
to requests routed via the ingress controller.

## Usage

```hcl
module "backend" {
  source = "github.com/dbalcomb/terraform-azurerm-aks-ingress//modules/backend"

  name      = "aks-backend"
  namespace = "aks-backend"
  image     = "nginx:latest"
  replicas  = 3

  volumes = {
    one = {
      name = "one"
      type = "config"
      path = "/azure/config"

      config = {
        name = "aks-backend-config"
        mode = "0777"

        items = [
          {
            name = "one.yml"
            mode = "0644"
            path = "path/to/one.yml"
          },
          {
            name = "two.yml"
            mode = "0700"
            path = "path/to/two.yml"
          }
        ]
      }
    }

    two = {
      name = "two"
      type = "secret"
      path = "/azure/secret"

      secret = {
        name = "aks-backend-secret"
        mode = "0777"
      }
    }

    three = {
      name      = "three"
      type      = "share"
      path      = "/azure/share"
      directory = "production"
      read_only = true

      share = {
        name = "myshare"

        account = {
          name = "myaccount"
          keys = ["key"]
        }
      }
    }
  }
}
```

## Inputs

| Name                             | Type     | Default    | Description                                         |
| -------------------------------- | -------- | ---------- | --------------------------------------------------- |
| `name`                           | `string` |            | The backend name                                    |
| `namespace`                      | `string` | `null`     | The backend namespace or `null` to create a new one |
| `image`                          | `string` |            | The docker image name                               |
| `replicas`                       | `number` | `1`        | The replica count                                   |
| `volumes`                        | `object` |            | The volume configuration                            |
| `volumes.*`                      | `object` |            | The volume instance configuration                   |
| `volumes.*.type`                 | `string` |            | The volume type (`config`, `secret` or `share`)     |
| `volumes.*.name`                 | `string` | *computed* | The volume name (defaults to volume key)            |
| `volumes.*.path`                 | `string` |            | The volume mount path                               |
| `volumes.*.directory`            | `string` | `""`       | The volume source path                              |
| `volumes.*.read_only`            | `bool`   | `false`    | Enable read-only access to volume                   |
| `volumes.*.config`               | `object` | `null`     | The `config` volume type configuration              |
| `volumes.*.config.name`          | `string` |            | The Kubernetes config name                          |
| `volumes.*.config.mode`          | `string` | `0644`     | The Kubernetes config permissions mode default      |
| `volumes.*.config.items`         | `list`   | *all*      | The Kubernetes config file list                     |
| `volumes.*.config.items.*`       | `object` |            | The Kubernetes config file configuration            |
| `volumes.*.config.items.*.name`  | `string` |            | The Kubernetes config file name                     |
| `volumes.*.config.items.*.mode`  | `string` | `null`     | The Kubernetes config file permissions mode         |
| `volumes.*.config.items.*.path`  | `string` |            | The Kubernetes config file mount path               |
| `volumes.*.secret`               | `object` | `null`     | The `secret` volume type configuration              |
| `volumes.*.secret.name`          | `string` |            | The Kubernetes secret name                          |
| `volumes.*.secret.mode`          | `string` | `0644`     | The Kubernetes secret permissions mode default      |
| `volumes.*.secret.items`         | `list`   | *all*      | The Kubernetes secret file list                     |
| `volumes.*.secret.items.*`       | `object` |            | The Kubernetes secret file configuration            |
| `volumes.*.secret.items.*.name`  | `string` |            | The Kubernetes secret file name                     |
| `volumes.*.secret.items.*.mode`  | `string` | `null`     | The Kubernetes secret file permissions mode         |
| `volumes.*.secret.items.*.path`  | `string` |            | The Kubernetes secret file mount path               |
| `volumes.*.share`                | `object` | `null`     | The `share` volume type configuration               |
| `volumes.*.share.name`           | `string` |            | The Azure file share name                           |
| `volumes.*.share.account`        | `object` |            | The Azure storage account configuration             |
| `volumes.*.share.account.name`   | `string` |            | The Azure storage account name                      |
| `volumes.*.share.account.keys`   | `list`   |            | The Azure storage account access keys               |
| `volumes.*.share.account.keys.*` | `string` |            | The Azure storage account access key                |

## Outputs

| Name        | Type     | Description              |
| ----------- | -------- | ------------------------ |
| `name`      | `string` | The backend name         |
| `namespace` | `string` | The backend namespace    |
| `port`      | `number` | The backend port         |
| `image`     | `string` | The docker image name    |
| `replicas`  | `number` | The replica count        |
| `volumes`   | `object` | The volume configuration |
