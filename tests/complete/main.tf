module "ingress" {
  source = "../../"

  name     = "aks-ingress"
  region   = "uksouth"
  replicas = 3
  metrics  = true

  cluster = {
    service_principal = {
      id = "00000000-0000-0000-0000-000000000000"
    }
  }
}

module "backend" {
  source = "../../modules/backend"

  name      = "aks-ingress-backend"
  namespace = "aks-ingress-backend"
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

module "route" {
  source = "../../modules/route"

  name    = "aks-backend-route"
  path    = "/"
  backend = module.backend

  host = {
    name = "www.example.com"
  }

  ingress = {
    class = "traefik"
  }

  issuer = {
    name = "aks-issuer"
  }
}
