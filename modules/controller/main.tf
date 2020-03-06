locals {
  labels = {
    "app.kubernetes.io/name"       = "ingress-controller"
    "app.kubernetes.io/instance"   = substr(var.name, 0, 63)
    "app.kubernetes.io/component"  = "controller"
    "app.kubernetes.io/part-of"    = "ingress"
    "app.kubernetes.io/managed-by" = "terraform"
  }
}

resource "kubernetes_service_account" "main" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = local.labels
  }
}

resource "kubernetes_service" "main" {
  metadata {
    name      = var.name
    namespace = var.namespace
    labels    = local.labels

    annotations = {
      "service.beta.kubernetes.io/azure-load-balancer-resource-group" = var.resource_group_name
    }
  }

  spec {
    type             = "LoadBalancer"
    load_balancer_ip = var.ip_address
    selector         = local.labels

    port {
      name        = "http"
      port        = 80
      protocol    = "TCP"
      target_port = "http"
    }

    port {
      name        = "https"
      port        = 443
      protocol    = "TCP"
      target_port = "https"
    }
  }
}

locals {
  config = templatefile("${path.module}/templates/traefik.toml", {
    class   = var.class
    metrics = var.metrics
  })
}

resource "kubernetes_config_map" "main" {
  metadata {
    name      = format("%s-config", var.name)
    namespace = var.namespace
    labels    = local.labels
  }

  data = {
    "traefik.toml" = local.config
  }
}

resource "kubernetes_deployment" "main" {
  metadata {
    name      = var.name
    namespace = var.namespace
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

        annotations = {
          "checksum/config"      = sha256(local.config)
          "prometheus.io/scrape" = var.metrics ? "true" : "false"
          "prometheus.io/path"   = var.metrics ? "/metrics" : null
          "prometheus.io/port"   = var.metrics ? "9100" : null
        }
      }

      spec {
        service_account_name            = kubernetes_service_account.main.metadata.0.name
        automount_service_account_token = true

        node_selector = {
          "kubernetes.io/os" = "linux"
        }

        container {
          name  = "ingress-controller"
          image = var.image
          args  = ["--configfile=/config/traefik.toml"]

          port {
            name           = "http"
            protocol       = "TCP"
            container_port = 80
          }

          port {
            name           = "https"
            protocol       = "TCP"
            container_port = 443
          }

          port {
            name           = "ping"
            protocol       = "TCP"
            container_port = 8082
          }

          dynamic "port" {
            for_each = var.metrics ? ["metrics"] : []

            content {
              name           = "metrics"
              protocol       = "TCP"
              container_port = 9100
            }
          }

          readiness_probe {
            initial_delay_seconds = 10
            period_seconds        = 10
            timeout_seconds       = 2
            success_threshold     = 1
            failure_threshold     = 1

            http_get {
              path   = "/ping"
              port   = "ping"
              scheme = "HTTP"
            }
          }

          liveness_probe {
            initial_delay_seconds = 10
            period_seconds        = 10
            timeout_seconds       = 2
            success_threshold     = 1
            failure_threshold     = 3

            http_get {
              path   = "/ping"
              port   = "ping"
              scheme = "HTTP"
            }
          }

          volume_mount {
            name       = "config"
            mount_path = "/config"
            read_only  = true
          }
        }

        volume {
          name = "config"

          config_map {
            name = kubernetes_config_map.main.metadata.0.name
          }
        }
      }
    }
  }
}

resource "kubernetes_pod_disruption_budget" "main" {
  metadata {
    name      = format("%s-pdb", var.name)
    namespace = var.namespace
    labels    = local.labels
  }

  spec {
    min_available = 1

    selector {
      match_labels = local.labels
    }
  }
}

resource "kubernetes_cluster_role" "rbac" {
  metadata {
    name   = format("%s-rbac", var.name)
    labels = local.labels
  }

  rule {
    api_groups = [""]
    resources  = ["pods", "services", "endpoints", "secrets"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["extensions", "networking.k8s.io"]
    resources  = ["ingresses"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["extensions", "networking.k8s.io"]
    resources  = ["ingresses/status"]
    verbs      = ["update"]
  }
}

resource "kubernetes_cluster_role_binding" "rbac" {
  metadata {
    name   = format("%s-rbac", var.name)
    labels = local.labels
  }

  role_ref {
    name      = kubernetes_cluster_role.rbac.metadata.0.name
    kind      = "ClusterRole"
    api_group = "rbac.authorization.k8s.io"
  }

  subject {
    name      = kubernetes_service_account.main.metadata.0.name
    namespace = kubernetes_service_account.main.metadata.0.namespace
    kind      = "ServiceAccount"
  }
}
