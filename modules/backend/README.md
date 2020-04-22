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

  configs = {
    config = {
      name = "config"
      path = "/config"
      mode = "0644"

      config = {
        name = "aks-ingress-backend-config"
      }
    }
  }

  secrets = {
    secret = {
      name = "secret"
      path = "/secret"
      mode = "0644"

      secret = {
        name = "aks-ingress-backend-secret"
      }
    }
  }

  files = {
    files = {
      name   = "files"
      source = "files"
      target = "/files"
      write  = false

      share = {
        name = "myshare"

        account = {
          name = "mystorageaccount"
          keys = ["key"]
        }
      }
    }
  }
}
```

## Inputs

| Name                           | Type     | Default    | Description                                         |
| ------------------------------ | -------- | ---------- | --------------------------------------------------- |
| `name`                         | `string` |            | The backend name                                    |
| `namespace`                    | `string` | `null`     | The backend namespace or `null` to create a new one |
| `image`                        | `string` |            | The docker image name                               |
| `replicas`                     | `number` | `1`        | The replica count                                   |
| `configs`                      | `object` | `{}`       | The config volume mount configuration               |
| `configs.*`                    | `object` |            | A config volume mount configuration entry           |
| `configs.*.name`               | `string` | *computed* | The config volume mount name                        |
| `configs.*.path`               | `string` | *computed* | The config volume mount path                        |
| `configs.*.mode`               | `string` | `"0644"`   | The config volume mount file permissions            |
| `configs.*.config`             | `object` |            | The config resource configuration                   |
| `configs.*.config.name`        | `string` |            | The config resource name                            |
| `secrets`                      | `object` | `{}`       | The secret volume mount configuration               |
| `secrets.*`                    | `object` |            | A secret volume mount configuration entry           |
| `secrets.*.name`               | `string` | *computed* | The secret volume mount name                        |
| `secrets.*.path`               | `string` | *computed* | The secret volume mount path                        |
| `secrets.*.mode`               | `string` | `"0644"`   | The secret volume mount file permissions            |
| `secrets.*.config`             | `object` |            | The secret resource configuration                   |
| `secrets.*.config.name`        | `string` |            | The secret resource name                            |
| `files`                        | `object` | `{}`       | The file share volume mount configuration           |
| `files.*`                      | `object` |            | A file share volume mount configuration entry       |
| `files.*.name`                 | `string` | *computed* | The file share volume mount name                    |
| `files.*.source`               | `string` | `""`       | The source directory in the file share              |
| `files.*.target`               | `string` | *computed* | The target path in the container                    |
| `files.*.write`                | `bool`   | `true`     | Enable write access to files                        |
| `files.*.share`                | `object` |            | The file share configuration                        |
| `files.*.share.name`           | `string` |            | The file share name                                 |
| `files.*.share.account`        | `object` |            | The file share storage account configuration        |
| `files.*.share.account.name`   | `string` |            | The storage account name                            |
| `files.*.share.account.keys`   | `list`   |            | The storage account access keys                     |
| `files.*.share.account.keys.*` | `string` |            | A storage account access key                        |

## Outputs

| Name        | Type     | Description                               |
| ----------- | -------- | ----------------------------------------- |
| `name`      | `string` | The backend name                          |
| `namespace` | `string` | The backend namespace                     |
| `port`      | `number` | The backend port                          |
| `image`     | `string` | The docker image name                     |
| `replicas`  | `number` | The replica count                         |
| `configs`   | `object` | The config volume mount configuration     |
| `secrets`   | `object` | The secret volume mount configuration     |
| `files`     | `object` | The file share volume mount configuration |
