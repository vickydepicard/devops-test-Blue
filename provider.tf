terraform {
  required_version = ">= 1.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version =  "~> 6.0"           #"~> 5.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 4.46.0"
    }
  }

  backend "gcs" {
    bucket = "tf-state-devops-test-terraform"
    prefix = "terraform/state/cloud_sql"
  }
}

provider "google" {
  project = var.project_identifier
  region  = var.region_code
}

provider "google-beta" {
  project = var.project_identifier
  region  = var.region_code
}
