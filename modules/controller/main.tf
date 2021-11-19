locals {
  metrics = {
    "controller.metrics.enabled"                                    = "true"
    "controller.metrics.service.annotations.prometheus\\.io/scrape" = "true"
    "controller.metrics.service.annotations.prometheus\\.io/port"   = "10254"
  }
}

resource "helm_release" "main" {
  name       = var.name
  namespace  = var.namespace
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.0.8"

  set {
    name  = "fullnameOverride"
    value = var.name
  }

  set {
    name  = "controller.ingressClassResource.name"
    value = var.class
  }

  set {
    name  = "controller.ingressClassResource.controllerValue"
    value = format("k8s.io/ingress-%s", var.class)
  }

  set {
    name  = "controller.replicaCount"
    value = var.replicas
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
    value = var.ip_address.group
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = var.ip_address.value
  }

  set {
    name  = "controller.nodeSelector.kubernetes\\.io/os"
    value = "linux"
  }

  set {
    name  = "controller.admissionWebhooks.patch.nodeSelector.kubernetes\\.io/os"
    value = "linux"
  }

  set {
    name  = "defaultBackend.nodeSelector.kubernetes\\.io/os"
    value = "linux"
  }

  set {
    name  = "controller.minAvailable"
    value = 1
  }

  dynamic "set" {
    for_each = var.metrics ? local.metrics : {}

    content {
      name  = set.key
      value = set.value
      type  = "string"
    }
  }
}
