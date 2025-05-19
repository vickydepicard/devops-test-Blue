output "lb_ip_address" {
  description = "IP publique du Load Balancer"
  value       = google_compute_global_forwarding_rule.http_forwarding.ip_address
}

output "lb_url" {
  description = "URL HTTP du Load Balancer"
  value       = "http://${google_compute_global_forwarding_rule.http_forwarding.ip_address}"
}
