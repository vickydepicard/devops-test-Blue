# Module Load Balancer HTTP(S)

## Description

Ce module déploie un Load Balancer HTTP global routant vers un service Cloud Run v2 (via NEG serverless). Il expose le port 80.

## Variables

- `project_id` : ID du projet GCP
- `region` : Région pour le NEG (ex: `europe-west1`)
- `service_name` : Nom du Cloud Run service
- `url_map_name` : Nom de la Compute URL Map
- `domain` : Domaine ou adresse IP pour front

## Sorties

- `lb_ip_address` : IP publique du Load Balancer
- `lb_url` : URL HTTP (http://IP)

## Exemple d’utilisation

```hcl
module "load_balancer" {
  source        = "./modules/load_balancer"
  project_id    = var.project_identifier
  region        = var.region_code
  service_name  = module.cloud_run.service_name
  url_map_name  = "lb-php-service-map"
  domain        = "*"
}
