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
  metadata {
    name   = var.name
    labels = local.labels
  }
}

resource "kubernetes_service" "main" {
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.main.metadata.0.name
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

resource "kubernetes_deployment" "main" {
  metadata {
    name      = var.name
    namespace = kubernetes_namespace.main.metadata.0.name
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
        }
      }
    }
  }
}

resource "kubernetes_pod_disruption_budget" "main" {
  metadata {
    name      = format("%s-pdb", var.name)
    namespace = kubernetes_namespace.main.metadata.0.name
    labels    = local.labels
  }

  spec {
    min_available = 1

    selector {
      match_labels = local.labels
    }
  }
}