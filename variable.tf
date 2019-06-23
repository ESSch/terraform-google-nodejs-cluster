variable "endpoint" {}

variable "cluster_ca_certificate" {}

variable "access_token" {}

variable "number_replicas" {
  default = 3
}

variable "name_app" {
  default = "NodeJS"
}

variable "name_container" {
  default = "node-js"
}

variable "name_service" {
  default = "terraform-nodejs"
}

variable "image" {
  default = "nginx:1.17"
}

variable "extend_port" {
  default = 80
}

variable "app_port" {
  default = 80
}

variable "limit_cpu" {
  default = "0.5"
}

variable "limit_memory" {
  default = "2000Mi"
}

