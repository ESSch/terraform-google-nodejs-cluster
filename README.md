uses
```
provider "google" {
    credentials = file("./kubernetes_key.json")
    project     = "node-cluster-243923"
    region      = "europe-west2"
}

module "kubernetes" {
    source  = "ESSch/kubernetes/google"
    version = "0.0.2"
    
    project_name = "node-cluster-243923"
    region = "europe-west2"
}

module "nodejs-cluster" {
    source  = "ESSch/nodejs-cluster/google"
    version = "0.0.1"
    endpoint = module.k8s.endpoint
    cluster_ca_certificate = module.k8s.cluster_ca_certificate
}
```
Link: https://registry.terraform.io/modules/ESSch/nodejs-cluster/google/