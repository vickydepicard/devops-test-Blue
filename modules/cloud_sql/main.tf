resource "random_password" "admin_pw" {
  length           = 16
  special          = true
  override_special = "!@#$%^&*()-_=+[]{}"
}

resource "google_sql_database_instance" "instance" {
  name             = var.instance_label
  project          = var.project_identifier
  database_version = var.db_version
  region           = var.deployment_region

  settings {
    tier = var.instance_tier

    ip_configuration {
      ipv4_enabled = true
    }
  }

  deletion_protection = false
}

resource "google_sql_database" "app_db" {
  name     = "app_db"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "admin_user" {
  name     = "db_admin"
  instance = google_sql_database_instance.instance.name
  password_wo = random_password.admin_pw.result
}

