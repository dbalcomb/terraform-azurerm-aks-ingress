locals {
  labels = {
    "app.kubernetes.io/name"       = "ingress-route"
    "app.kubernetes.io/instance"   = substr(var.name, 0, 63)
    "app.kubernetes.io/component"  = "route"
    "app.kubernetes.io/part-of"    = "ingress"
    "app.kubernetes.io/managed-by" = "terraform"
  }
}

locals {
  hosts = [for host in (var.host == null ? var.hosts : concat([var.host], var.hosts)) : can(host.name) ? host.name : host]
}

resource "kubernetes_ingress" "main" {
  metadata {
    name      = var.name
    namespace = var.backend.namespace
    labels    = local.labels

    annotations = {
      "cert-manager.io/cluster-issuer"           = try(var.issuer.name, null)
      "nginx.ingress.kubernetes.io/ssl-redirect" = can(var.issuer.name) ? "true" : "false"
    }
  }

  spec {
    ingress_class_name = var.ingress.class

    dynamic "rule" {
      for_each = local.hosts

      content {
        host = rule.value

        http {
          path {
            path = var.path

            backend {
              service_name = var.backend.name
              service_port = var.backend.port
            }
          }
        }
      }
    }

    dynamic "tls" {
      for_each = can(var.issuer.name) ? ["issuer"] : []

      content {
        secret_name = format("%s-tls", var.name)
        hosts       = local.hosts
      }
    }
  }
}
