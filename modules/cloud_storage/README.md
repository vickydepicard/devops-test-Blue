# Module Terraform - Cloud Storage (Google Cloud)

## Description
Ce module Terraform crée un bucket Cloud Storage sur Google Cloud Platform (GCP).  
Il permet la gestion simplifiée des buckets pour stocker des fichiers statiques avec :  
- Activation du versioning des objets  
- Accès uniforme au niveau du bucket  
- Suppression forcée possible (force_destroy)

## Utilisation

### Exemple d'appel du module

```hcl
module "cloud_storage" {
  source      = "./modules/cloud_storage"
  bucket_name = "mon-bucket-unique-12345"
  location    = "europe-west1"
}
