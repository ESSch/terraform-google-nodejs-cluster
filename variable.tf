variable "endpoint" {}

variable "cluster_ca_certificate" {}

variable "access_token" {}

variable "number_replicas" {
  default = 3
}

variable "name_image" {
  default = "node-js"
}

variable "name_service" {
  default = "terraform-nodejs"
}

variable "image" {
  default = "google/nodejs-hello"
}

variable "target_port" {
  default = 80
}

variable "app_port" {
  default = 80
}

