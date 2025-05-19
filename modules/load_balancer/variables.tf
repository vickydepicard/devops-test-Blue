variable "project_id" {
  description = "ID du projet Google Cloud"
  type        = string
}

variable "region" {
  description = "Région pour ressources régionales (ex: europe-west1)"
  type        = string
  default     = "europe-west1"
}

variable "service_name" {
  description = "Nom du service Cloud Run cible du LB"
  type        = string
}

variable "url_map_name" {
  description = "Nom de la ressource url map"
  type        = string
}

variable "domain" {
  description = "Domaine ou IP (wildcard) pour le frontend"
  type        = string
}
