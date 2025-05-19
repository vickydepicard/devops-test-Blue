variable "project_identifier" {
  description = "ID du projet Google Cloud"
  type        = string
}

variable "instance_label" {
  description = "Nom de l’instance Cloud SQL"
  type        = string
}

variable "db_version" {
  description = "Version MySQL"
  type        = string
}

variable "instance_tier" {
  description = "Type de machine"
  type        = string
}

variable "deployment_region" {
  description = "Région de déploiement"
  type        = string
}

