terraform {
  required_version = ">= 0.12.0"
}

provider "kubernetes" {
  host = var.endpoint

  token = var.access_token
  cluster_ca_certificate = var.cluster_ca_certificate

  load_config_file = false
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
          image = "node:12"
          name  = "node-js"
          command = ["/bin/bash"]
          args = [
            "-c",
            "cd /usr/src/ && git clone https://github.com/fhinkel/nodejs-hello-world.git && /usr/local/bin/node /usr/src/nodejs-hello-world/index.js"
          ]
        }
      }
    }
  }
}

resource "kubernetes_service" "nodejs" {
  metadata {
    name = "terraform-nodejs"
  }
  spec {
    selector = {
      app = kubernetes_deployment.nodejs.metadata.0.labels.app
    }
    port {
      port = var.app_port
      target_port = var.target_port
    }

    type = "LoadBalancer"
  }
}