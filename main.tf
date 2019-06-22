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
    name = var.name_service
    labels = {
      app = var.name_app
    }
  }
  spec {
    replicas = var.number_replicas
    selector {
      match_labels = {
        app = var.name_app
      }
    }
    template {
      metadata {
        labels = {
          app = var.name_app
        }
      }
      spec {
        container {
          image = var.image
          name  = var.name_container
        }
      }
    }
  }
  depends_on = [var.endpoint]
}

resource "kubernetes_service" "nodejs" {
  metadata {
    name = var.name_service
  }
  spec {
    selector = {
      app = kubernetes_deployment.nodejs.metadata.0.labels.app
    }
    port {
      port = var.extend_port
      target_port = var.app_port
    }

    type = "LoadBalancer"
  }
  depends_on = [kubernetes_deployment.nodejs]
}
