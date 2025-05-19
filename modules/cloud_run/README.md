# Module Cloud Run v2

Ce module Terraform déploie un service Cloud Run v2 (API Beta) pour une application PHP-FPM + Nginx, en exposant un port personnalisé (3002).

## Description

- Utilise la ressource `google_cloud_run_v2_service` du provider `google-beta` pour tirer parti de l’API Cloud Run v2.  
- Expose le port 3002 via le bloc `ports { container_port = 3002 }`.  
- Crée la règle IAM `roles/run.invoker` pour rendre le service accessible publiquement.  

## Fichiers

- `main.tf` : définition des resources Cloud Run v2 et IAM.  
- `variables.tf` : déclaration des variables d’entrée.  
- `outputs.tf` : sorties du module (URL publique).  
- `README.md` : documentation d’utilisation.  

## Variables d’entrée

| Nom            | Type   | Description                                | Valeur par défaut |
| -------------- | ------ | ------------------------------------------ | ----------------- |
| `project_id`   | string | ID du projet Google Cloud                  | N/A               |
| `region`       | string | Région de déploiement (ex : `europe-west1`)| `europe-west1`    |
| `service_name` | string | Nom du service Cloud Run                   | N/A               |
| `image`        | string | URL de l’image Docker (GCR/Artifact)       | N/A               |

## Sorties

| Nom   | Description                     |
| ----- | ------------------------------- |
| `url` | URL publique du service déployé |

## Exemple d’utilisation

```hcl
module "cloud_run" {
  source       = "./modules/cloud_run"
  project_id   = var.project_identifier
  region       = var.region_code
  service_name = "php-fpm-service"
  image        = "gcr.io/${var.project_identifier}/php-fpm-app:latest"
}

Documentation GCP
Cloud Run v2 API :
https://cloud.google.com/run/docs/reference/rest/v2/projects.locations.services

Terraform resource :
https://registry.terraform.io/providers/hashicorp/google-beta/latest/docs/resources/cloud_run_v2_service
