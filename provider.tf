terraform {
  required_version = ">= 1.3"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0"
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

