locals {
  labels = {
    "app.kubernetes.io/name"       = "ingress-route"
    "app.kubernetes.io/instance"   = substr(var.name, 0, 63)
    "app.kubernetes.io/component"  = "route"
    "app.kubernetes.io/part-of"    = "ingress"
    "app.kubernetes.io/managed-by" = "terraform"
  }
}

resource "kubernetes_ingress" "main" {
  metadata {
    name      = var.name
    namespace = var.backend.namespace
    labels    = local.labels

    annotations = {
      "kubernetes.io/ingress.class" = var.ingress.class
    }
  }

  spec {
    rule {
      host = var.host.name

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
}
