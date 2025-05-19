output "url" {
  description = "URL publique du service Cloud Run"
  value       = google_cloud_run_v2_service.default.uri
}

