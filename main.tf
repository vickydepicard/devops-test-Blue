module "db_module" {
  source             = "./modules/cloud_sql"
  project_identifier = var.project_identifier
  instance_label     = "devops-sql-instance"
  db_version         = "MYSQL_8_0"
  instance_tier      = "db-f1-micro"
  deployment_region  = var.region_code
}

module "cloud_storage" {
  source      = "./modules/cloud_storage"
  bucket_name = "mon-bucket-unique-12345"
  location    = "europe-west1"
}

module "cloud_run" {
  source       = "./modules/cloud_run"
  project_id   = var.project_identifier
  region       = var.region_code
  service_name = "php-fpm-service"
  image        = "gcr.io/${var.project_identifier}/php-fpm-app:latest"
}

