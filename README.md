uses
```
provider "google" {
  credentials = file("./kubernetes_key.json")
  project     = "node-cluster-243923"
  region      = "europe-west2"
}

module "k8s" {
  source       = "./k8s"
  project_name = "node-cluster-243923"
  region       = "europe-west2"
}

module "nodejs" {
  source   = "./nodejs"
  endpoint = module.k8s.endpoint
  cluster_ca_certificate = module.k8s.cluster_ca_certificate
}
```