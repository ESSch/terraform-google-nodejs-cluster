terraform {
  required_version = ">= 0.12.0"
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host = var.endpoint

  token = data.google_client_config.default.access_token
  cluster_ca_certificate = var.cluster_ca_certificate

  load_config_file = false
}

resource "kubernetes_service" "nodejs" {
  metadata {
    name = "terraform-nodejs"
  }
  spec {
    selector = {
      App = kubernetes_deployment.nodejs.metadata.0.labels.app
    }
    port {
      port = 80
      target_port = var.target_port
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "nodejs" {
  metadata {
    name = "terraform-nodejs"
    labels = {
      app = "NodeJS"
    }
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "NodeJS"
      }
    }
    template {
      metadata {
        labels = {
          app = "NodeJS"
        }
      }
      spec {
        container {
          image = "nginx:1.7.8"
          name  = "node-js"
          command = [] # /usr/share/nginx/html
          # volume_mount
        }
      }
    }
  }
}