//output "nodejs_ip" {
//  value = kubernetes_service.nodejs.load_balancer_ingress.0.ip
//  sensitive = true
//}
//
//output "nodejs_hostname" {
//  value = kubernetes_service.nodejs.load_balancer_ingress.0.hostname
//  sensitive = true
//}
//
//output "url" {
//  value = "http://${var.endpoint}:${var.extend_port}"
//  sensitive = true
//}