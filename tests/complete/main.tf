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

  volumes = {
    one = {
      name = "one"
      type = "config"
      path = "/azure/config"

      config = {
        name = "aks-ingress-backend-config"
        mode = "0777"

        items = [
          {
            name = "one.yml"
            mode = "0644"
            path = "path/to/one.yml"
          },
          {
            name = "two.yml"
            mode = "0700"
            path = "path/to/two.yml"
          }
        ]
      }
    }

    two = {
      name = "two"
      type = "secret"
      path = "/azure/secret"

      secret = {
        name = "aks-ingress-backend-secret"
        mode = "0777"
      }
    }

    three = {
      name      = "three"
      type      = "share"
      path      = "/azure/share"
      directory = "production"
      read_only = true

      share = {
        name = "myshare"

        account = {
          name = "myaccount"
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
