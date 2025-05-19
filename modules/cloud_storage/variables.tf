variable "bucket_name" {
  description = "Nom du bucket Cloud Storage"
  type        = string
}

variable "location" {
  description = "Région du bucket"
  type        = string
  default     = "europe-west1"
}

