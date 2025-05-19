variable "project_id" {
  description = "ID du projet Google Cloud"
  type        = string
}

variable "region" {
  description = "Région de déploiement (ex: europe-west1)"
  type        = string
  default     = "europe-west1"
}

variable "service_name" {
  description = "Nom du service Cloud Run"
  type        = string
}

variable "image" {
  description = "URL de l'image du conteneur (GCR ou Artifact Registry)"
  type        = string
}

