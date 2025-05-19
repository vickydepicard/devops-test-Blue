resource "google_storage_bucket" "static_files" {
  name                        = var.bucket_name
  location                    = var.location
  force_destroy               = true
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = false
  }
}

