# devops-test-Blue  
**Test Technique – Ingénieur DevOps**

---

## 🚀 Présentation du Projet  
Ce dépôt rassemble ma solution au test technique DevOps sur Google Cloud Platform (GCP). À travers ce challenge, j’ai démontré ma capacité à :

- Appréhender rapidement Google Cloud (activation d’APIs, IAM, Artifact Registry…)  
- Concevoir une infrastructure sécurisée et modulaire en Terraform  
- Automatiser un pipeline CI/CD complet (GitHub Actions pour build, test, push, déploiement)  
- Écrire un script Bash fiable pour récupérer l’IP publique d’un service Cloud Run  

Ces étapes m’ont permis de renforcer mes compétences IaC, CI/CD et scripting, et témoignent de ma motivation pour le poste.

---

## 🗺️ Architecture & Composants  
1. **Cloud SQL (MySQL 8)**  
   - Instance `devops-sql-instance`  
   - Base de données `app_db`, utilisateur `db_admin`  
2. **Cloud Storage**  
   - Bucket `my-static-files` pour les assets statiques  
3. **Cloud Run**  
   - Service `php-fpm-app` exécutant PHP-FPM derrière Nginx  
4. **Load Balancer HTTP(S)**  
   - Routage global vers le service Cloud Run  

---

## 📂 Structure du Répertoire  

├── .github/
│ └── workflows/
│ └── ci-cd.yml # GitHub Actions CI/CD pipeline
├── modules/
│ ├── cloud_sql/ # Module Cloud SQL
│ ├── cloud_storage/ # Module Cloud Storage
│ ├── cloud_run/ # Module Cloud Run + Dockerfile
│ └── load_balancer/ # Module Load Balancer
├── Dockerfile # PHP-FPM + Nginx config
├── get-cloud-run-ip.sh # Script Bash de récupération d’IP
├── main.tf # Root Terraform configuration
├── provider.tf # Provider & backend
├── variables.tf # Variables Terraform
├── terraform.tfvars # Valeurs par défaut
├── outputs.tf # Outputs Terraform
└── README.md # Cette documentation


---

## ⚙️ Guide d’Installation & Déploiement

### 1. Prérequis  
- Compte GCP avec facturation active  
- SDK `gcloud`, Terraform v1.x et Docker installés  

### 2. Configuration des Variables d’Environnement  
```bash
export PROJECT_ID="devops-test-terraform-blue"
export REGION="europe-west1"
export TF_VAR_project_id=$PROJECT_ID
export TF_VAR_region=$REGION
export TF_VAR_bucket_name="my-static-files"
export TF_VAR_db_password="MotDePasseFort123!"


3. Infrastructure as Code (Terraform)

# Initialisation
terraform init

# Vérification de la configuration
terraform validate

# Planification
terraform plan -out=tfplan

# Application
terraform apply tfplan

# Affichage des outputs
terraform output

4. CI/CD Pipeline avec GitHub Actions

Dans GitHub → Settings → Secrets, créez :

GCP_PROJECT_ID

GCP_REGION

GCP_SERVICE_ACCOUNT_KEY (clé JSON du service account)

Le workflow .github/workflows/ci-cd.yml fait :

Checkout du code

Authentification GCP (google-github-actions/auth@v2)

Build et push Docker avec Buildx (docker/build-push-action@v3)

Déploiement sur Cloud Run (google-github-actions/deploy-cloudrun@v1)

5. Récupération de l’IP Publique : 

./get-cloud-run-ip.sh dev

suphotio@ubuntu-s-1vcpu-512mb-10gb-nyc1-01:~/BLUE/devops-test-Blue$ ./get-cloud-run-ip.sh dev
[2025-05-20 19:02:58] Démarrage du script pour l'environnement 'dev'
[2025-05-20 19:03:04] URL du service : https://mon-service-dev-364751985015.europe-west1.run.app
[2025-05-20 19:03:04] Adresse IP publique du service : 2600:1900:4245:200::

Adresse IP publique du service 'mon-service-dev' (dev) : 2600:1900:4245:200::

[2025-05-20 19:03:04] Script exécuté avec succès pour l'environnement 'dev'.


🚧 Retours d’Expérience & Résolution de Problèmes
Permissions IAM

Attribution de roles/iam.serviceAccountUser pour actAs

roles/artifactregistry.writer pour le push Docker

Activation d’APIs

cloudresourcemanager, iam, run, artifactregistry

Erreur “denied: Unauthenticated request”

Correct credential helper Docker + rôle IAM

Montée en compétences

Terraform modulaire (modules réutilisables)

Pipelines GitHub Actions documentés et testés

Script Bash robuste avec journalisation et gestion d’erreurs

🌱 Perspectives & Améliorations

Monitoring & Alerting : Cloud Monitoring, alertes 5xx/CPU

Sécurité : Secret Manager, Cloud Armor, OIDC sans clés JSON

Tests Automatisés : PHPUnit et couverture de code dans le pipeline

HA & DR : Multi-régions, backups Cloud SQL, stratégie DR dans dr.md

Documentation Automatique : intégration terraform-docs, diagrammes Mermaid

Extras : idées et expérimentations consignées dans extra.md

Ce projet, réalisé, démontre ma capacité à gérer de bout en bout un cycle DevOps : de la définition de l’infrastructure à son déploiement automatisé, en passant par la résolution proactive des problèmes et la documentation claire des solutions. J’aspire à mettre cette expertise et cette passion au service de votre équipe
