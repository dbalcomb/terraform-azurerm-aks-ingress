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
  configs = {
    for key, entry in var.configs : key => {
      name = try(entry.name, key)
      path = try(entry.path, format("/configs/%s", try(entry.name, key)))
      mode = try(entry.mode, "0644")

      config = {
        name = entry.config.name
      }
    }
  }

  secrets = {
    for key, entry in var.secrets : key => {
      name = try(entry.name, key)
      path = try(entry.path, format("/secrets/%s", try(entry.name, key)))
      mode = try(entry.mode, "0644")

      secret = {
        name = entry.secret.name
      }
    }
  }

  files = {
    for key, entry in var.files : key => {
      name   = try(entry.name, key)
      source = try(entry.source, "")
      target = try(entry.target, format("/files/%s", try(entry.name, key)))
      write  = try(entry.write, true)

      share = {
        name = entry.share.name

        account = {
          name = entry.share.account.name
          keys = entry.share.account.keys
        }
      }
    }
  }

  shares = {
    for key, entry in local.files : entry.share.name => entry.share
  }

  accounts = {
    for key, entry in local.shares : entry.account.name => entry.account
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
            for_each = local.configs

            content {
              name       = format("config-%s", volume_mount.value.name)
              mount_path = volume_mount.value.path
              sub_path   = ""
              read_only  = false
            }
          }

          dynamic "volume_mount" {
            for_each = local.secrets

            content {
              name       = format("secret-%s", volume_mount.value.name)
              mount_path = volume_mount.value.path
              sub_path   = ""
              read_only  = false
            }
          }

          dynamic "volume_mount" {
            for_each = local.files

            content {
              name       = format("file-%s", volume_mount.value.name)
              mount_path = volume_mount.value.target
              sub_path   = volume_mount.value.source
              read_only  = volume_mount.value.write ? false : true
            }
          }
        }

        dynamic "volume" {
          for_each = local.configs

          content {
            name = format("config-%s", volume.value.name)

            config_map {
              name         = volume.value.config.name
              default_mode = volume.value.mode
            }
          }
        }

        dynamic "volume" {
          for_each = local.secrets

          content {
            name = format("secret-%s", volume.value.name)

            secret {
              secret_name  = volume.value.secret.name
              default_mode = volume.value.mode
            }
          }
        }

        dynamic "volume" {
          for_each = local.files

          content {
            name = format("file-%s", volume.value.name)

            azure_file {
              secret_name = kubernetes_secret.account[volume.value.share.account.name].metadata.0.name
              share_name  = volume.value.share.name
              read_only   = volume.value.write ? false : true
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

resource "kubernetes_secret" "account" {
  for_each = local.accounts

  metadata {
    name      = format("%s-%s-account", var.name, each.key)
    namespace = local.namespace
    labels    = local.labels
  }

  data = {
    azurestorageaccountname = each.value.name
    azurestorageaccountkey  = each.value.keys.0
  }
}
