resource "google_cloud_run_v2_service" "default" {
  provider = google-beta # oblige Terraform à utiliser google-beta
  name     = var.service_name
  location = var.region
  project  = var.project_id

  template {
    containers {
      name  = var.service_name
      image = var.image

      # Expose le port 3002
      ports {
        container_port = 3002
      }
    }
  }
}


resource "google_cloud_run_v2_service_iam_member" "invoker" {
  provider = google-beta                     # utilisation du provider beta

  project  = google_cloud_run_v2_service.default.project
  location = google_cloud_run_v2_service.default.location

  # Nom du service Cloud Run (argument requis en v2, remplace `service`)
  name     = google_cloud_run_v2_service.default.name

  # Rôle et membre pour l’accès public
  role     = "roles/run.invoker"
  member   = "allUsers"
}

