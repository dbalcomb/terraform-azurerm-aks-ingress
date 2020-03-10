locals {
  labels = {
    "app.kubernetes.io/name"       = "ingress-backend"
    "app.kubernetes.io/instance"   = substr(var.name, 0, 63)
    "app.kubernetes.io/component"  = "backend"
    "app.kubernetes.io/part-of"    = "ingress"
    "app.kubernetes.io/managed-by" = "terraform"
  }
}

resource "kubernetes_namespace" "main" {
  count = var.namespace == null ? 1 : 0

  metadata {
    name   = var.name
    labels = local.labels
  }
}

locals {
  namespace = var.namespace == null ? kubernetes_namespace.main.0.metadata.0.name : var.namespace
}

resource "kubernetes_service" "main" {
  metadata {
    name      = var.name
    namespace = local.namespace
    labels    = local.labels
  }

  spec {
    type     = "ClusterIP"
    selector = local.labels

    port {
      name        = "http"
      port        = 80
      protocol    = "TCP"
      target_port = "http"
    }
  }
}

locals {
  volumes = {
    for key, volume in var.volumes : key => {
      type      = volume.type
      name      = try(volume.name, key)
      path      = try(volume.path, format("/azure/%s", try(volume.name, key)))
      directory = try(volume.directory, "")
      read_only = try(volume.read_only, false)

      config = volume.type != "config" ? null : {
        name = volume.config.name
        mode = try(volume.config.mode, "0644")

        items = [
          for item in try(volume.config.items, []) : {
            name = item.name
            path = item.path
            mode = try(item.mode, null)
          }
        ]
      }

      secret = volume.type != "secret" ? null : {
        name = volume.secret.name
        mode = try(volume.secret.mode, "0644")

        items = [
          for item in try(volume.secret.items, []) : {
            name = item.name
            path = item.path
            mode = try(item.mode, null)
          }
        ]
      }

      share = volume.type != "share" ? null : {
        name = volume.share.name

        account = {
          name = volume.share.account.name
          keys = volume.share.account.keys
        }
      }
    }
  }
}

resource "kubernetes_deployment" "main" {
  metadata {
    name      = var.name
    namespace = local.namespace
    labels    = local.labels
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = local.labels
    }

    template {
      metadata {
        labels = local.labels
      }

      spec {
        container {
          name  = var.name
          image = var.image

          port {
            name           = "http"
            protocol       = "TCP"
            container_port = 80
          }

          dynamic "volume_mount" {
            for_each = local.volumes

            content {
              name       = volume_mount.value.name
              mount_path = volume_mount.value.path
              sub_path   = volume_mount.value.directory
              read_only  = volume_mount.value.read_only
            }
          }
        }

        dynamic "volume" {
          for_each = local.volumes

          content {
            name = volume.value.name

            dynamic "config_map" {
              for_each = volume.value.type == "config" ? [""] : []

              content {
                name         = volume.value.config.name
                default_mode = volume.value.config.mode

                dynamic "items" {
                  for_each = volume.value.config.items

                  content {
                    key  = items.value.name
                    mode = items.value.mode
                    path = items.value.path
                  }
                }
              }
            }

            dynamic "secret" {
              for_each = volume.value.type == "secret" ? [""] : []

              content {
                secret_name  = volume.value.secret.name
                default_mode = volume.value.secret.mode

                dynamic "items" {
                  for_each = volume.value.secret.items

                  content {
                    key  = items.value.name
                    mode = items.value.mode
                    path = items.value.path
                  }
                }
              }
            }

            dynamic "azure_file" {
              for_each = volume.value.type == "share" ? [""] : []

              content {
                secret_name = kubernetes_secret.volume[volume.key].metadata.0.name
                share_name  = volume.value.share.name
                read_only   = volume.value.read_only
              }
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_pod_disruption_budget" "main" {
  metadata {
    name      = format("%s-pdb", var.name)
    namespace = local.namespace
    labels    = local.labels
  }

  spec {
    min_available = 1

    selector {
      match_labels = local.labels
    }
  }
}

resource "kubernetes_secret" "volume" {
  for_each = {
    for key, volume in local.volumes : key => volume
    if volume.type == "share"
  }

  metadata {
    name      = format("%s-%s-volume", var.name, each.key)
    namespace = local.namespace
    labels    = local.labels
  }

  data = {
    azurestorageaccountname = each.value.share.account.name
    azurestorageaccountkey  = each.value.share.account.keys.0
  }
}
