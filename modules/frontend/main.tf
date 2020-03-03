locals {
  labels = {
    "app.kubernetes.io/name"       = "ingress-frontend"
    "app.kubernetes.io/instance"   = substr(var.name, 0, 63)
    "app.kubernetes.io/component"  = "frontend"
    "app.kubernetes.io/part-of"    = "ingress"
    "app.kubernetes.io/managed-by" = "terraform"
  }
}

resource "kubernetes_ingress" "main" {
  for_each = var.routes

  metadata {
    name      = format("%s-%s", var.name, each.key)
    namespace = each.value.backend.namespace
    labels    = local.labels

    annotations = {
      "kubernetes.io/ingress.class" = "traefik"
    }
  }

  spec {
    rule {
      host = each.value.host

      http {
        path {
          path = each.value.path

          backend {
            service_name = each.value.backend.name
            service_port = each.value.backend.port
          }
        }
      }
    }
  }
}
