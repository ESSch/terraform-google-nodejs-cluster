This module run any container image as kubernetes cluster.
### Simple uses
```
provider "google" {
  credentials = file("./kubernetes_key.json")
  project     = "node-cluster-243923"
  region      = "europe-west2"
}

module "kubernetes" {
  source  = "ESSch/kubernetes/google"
  version = "~>0.0.6"
}

data "google_client_config" "default" {}

module "nodejs" {
  source  = "ESSch/nodejs-cluster/google"
  version = "~>0.0.2"
  endpoint = module.kubernetes.endpoint
  access_token = data.google_client_config.default.access_token
  cluster_ca_certificate = module.kubernetes.cluster_ca_certificate
}
```
### Uses to secret
Put file {name_secret}.json in page of your project. You secret file is /{name_secret}/.dockerconfigjson
```
module "nodejs" {
  source  = "ESSch/nodejs-cluster/google"
  version = "~>0.0.2"
  endpoint = module.kubernetes.endpoint
  access_token = data.google_client_config.default.access_token
  cluster_ca_certificate = module.kubernetes.cluster_ca_certificate
  name_secret = "nodejs-secret"
}
```
Link: https://registry.terraform.io/modules/ESSch/nodejs-cluster/google/