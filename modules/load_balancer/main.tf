provider "google" {
  project = var.project_id
  region  = var.region
}
provider "google-beta" {
  project = var.project_id
  region  = var.region
}

# Backend Service Cloud Run (Serverless NEG)
resource "google_compute_region_network_endpoint_group" "neg" {
  name                  = "${var.service_name}-neg"
  network_endpoint_type = "SERVERLESS"
  region                = var.region

  cloud_run {
    service = var.service_name
    tag     = "latest"
  }
}

# URL Map pour router tout le trafic
resource "google_compute_url_map" "url_map" {
  name            = var.url_map_name
  default_service = google_compute_region_network_endpoint_group.neg.id
}

# HTTP(S) Proxy
resource "google_compute_target_http_proxy" "http_proxy" {
  name   = "${var.url_map_name}-http-proxy"
  url_map = google_compute_url_map.url_map.self_link
}

# Forwarding Rule
resource "google_compute_global_forwarding_rule" "http_forwarding" {
  name       = "${var.url_map_name}-http-rule"
  port_range = "80"
  target     = google_compute_target_http_proxy.http_proxy.self_link
}
