# devops-test-Blue
# DevOps Engineer Technical Test

Ce projet évalue vos compétences en Infrastructure as Code (IaC) avec Terraform, en développement de pipeline CI/CD via GitHub Actions, et en scripting Bash, dans le contexte d'une application PHP-FPM déployée sur Google Cloud Platform (GCP).

## Architecture Déployée

- **Cloud SQL (MySQL 8)** : Instance `devops-sql-instance` avec une base de données `app_db` et un utilisateur `db_admin`.
- **Cloud Storage** : Bucket `my-static-files` pour le stockage des fichiers statiques.
- **Cloud Run** : Service `php-fpm-app` exécutant une application PHP-FPM derrière un proxy Nginx.
- **Load Balancer HTTP(S)** : Routage du trafic vers le service Cloud Run via un Load Balancer HTTP(S) global.

## Arborescence du Projet

├── README.md
├── main.tf
├── provider.tf
├── variables.tf
├── terraform.tfvars
├── outputs.tf
├── modules/
│ ├── cloud_sql/
│ ├── cloud_storage/
│ ├── cloud_run/
│ └── load_balancer/
├── .github/
│ └── workflows/
│ └── ci-cd.yml
├── get-cloud-run-ip.sh
└── Dockerfile


## Prérequis

- Compte Google Cloud avec facturation activée.
- SDK `gcloud` installé et configuré.
- Terraform installé.
- Docker installé (pour la construction de l'image).

## Configuration des Variables d'Environnement

Avant d'exécuter Terraform, définissez les variables d'environnement nécessaires :

```bash
export TF_VAR_project_id="votre-id-de-projet"
export TF_VAR_region="europe-west1"
export TF_VAR_bucket_name="my-static-files"
export TF_VAR_db_password="motdepassefort"

# Déploiement de l'Infrastructure avec Terraform

## Initialisation :

```bash
terraform init

Validation de la configuration :

# Initialiser Terraform et backend
terraform init

# Vérifier la configuration
terraform validate

# Générer un plan d’exécution
terraform plan -out=tfplan

# Appliquer la configuration
terraform apply tfplan

# Afficher les outputs
terraform output

Pipeline CI/CD avec GitHub Actions

Workflow GitHub Actions

Créez un fichier .github/workflows/ci-cd.yml avec le contenu suivant :

yaml

name: CI/CD Pipeline

on:
  push:
    branches:
      - main
    paths:
      - 'terraform/**'
      - 'Dockerfile'
      - '.github/workflows/ci-cd.yml'

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Vérifier le code
        uses: actions/checkout@v2

      - name: Configurer Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.3.0

      - name: Initialiser Terraform
        run: terraform init

      - name: Valider la configuration Terraform
        run: terraform validate

      - name: Planifier le déploiement Terraform
        run: terraform plan -out=tfplan

      - name: Appliquer le déploiement Terraform
        run: terraform apply -auto-approve tfplan

      - name: Construire l'image Docker
        run: |
          docker build -t gcr.io/$GCP_PROJECT_ID/php-fpm-app:latest .
          echo ${{ secrets.GCP_SERVICE_ACCOUNT_KEY }} | docker login -u _json_key --password-stdin https://gcr.io

      - name: Pousser l'image Docker
        run: docker push gcr.io/$GCP_PROJECT_ID/php-fpm-app:latest

      - name: Déployer sur Cloud Run
        run: |
          gcloud run deploy php-fpm-app \
            --image gcr.io/$GCP_PROJECT_ID/php-fpm-app:latest \
            --platform managed \
            --region $GCP_REGION \
            --allow-unauthenticated
Variables d'environnement
Définissez les variables suivantes dans les secrets de votre dépôt GitHub :

GCP_PROJECT_ID: ID de votre projet Google Cloud.

GCP_REGION: Région de déploiement (par exemple, europe-west1).

GCP_SERVICE_ACCOUNT_KEY: Clé JSON de votre compte de service Google Cloud.

Accès à l'Application Déployée
Une fois le déploiement terminé, accédez à l'application via l'URL fournie dans les outputs Terraform.

Exécution du Script Bash pour Récupérer l'IP Publique
Le script get-cloud-run-ip.sh permet de récupérer l'adresse IP publique du service Cloud Run :

bash
Copier
Modifier
./get-cloud-run-ip.sh
Dépannage
Problème d'accès au socket Docker : Si vous rencontrez une erreur liée au socket Docker, assurez-vous que votre utilisateur a les permissions appropriées ou exécutez les commandes Docker avec sudo.

Problème de connexion à Cloud Run : Vérifiez que le service Cloud Run est correctement déployé et que les règles de pare-feu permettent l'accès.

Problèmes Rencontrés et Solutions
Problème de permissions lors du push Docker : L'erreur denied: Unauthenticated request indique un problème d'authentification. Assurez-vous que vous êtes connecté à Google Cloud avec les bonnes permissions et que Docker est configuré pour utiliser les identifiants appropriés.

Améliorations pour un Environnement de Production
Pour rendre cet environnement prêt pour la production, envisagez les améliorations suivantes :

Surveillance : Intégration de Stackdriver pour la surveillance des ressources et des logs.

Sécurité : Mise en place de rôles IAM stricts, utilisation de secrets via Secret Manager, et configuration de Cloud Armor pour la protection DDoS.

CI/CD : Ajout de tests unitaires et d'intégration dans le pipeline GitHub Actions, et utilisation de Cloud Build pour la construction des images Docker.

Haute disponibilité : Déploiement multi-régions pour assurer la disponibilité continue de l'application.

Références

Terraform Google Cloud SQL Module

Terraform Google Cloud Run Module

Terraform Google Cloud Storage Module

Terraform Google Load Balancer Module

GitHub Actions Documentation
