# devops-test-Blue  
**Test Technique – Ingénieur DevOps**

##  Présentation du Projet  
Ce dépôt contient ma solution au test technique DevOps sur Google Cloud Platform (GCP). À travers ce challenge :

Maîtriser rapidement GCP : activation des APIs, gestion des IAM, utilisation d’Artifact Registry.

Concevoir une infrastructure modulaire et sécurisée avec Terraform.

Automatiser un pipeline CI/CD complet : build, test, push et déploiement via GitHub Actions.

Développer un script Bash robuste pour récupérer l’IP publique d’un service Cloud Run.

Ces étapes illustrent mes compétences en IaC, CI/CD et scripting, témoignant de ma motivation pour le poste.

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

.
├── .github/
│   └── workflows/
│       └── ci-cd.yml               # Pipeline CI/CD GitHub Actions
├── modules/
│   ├── cloud_sql/                  # Module Terraform pour Cloud SQL
│   ├── cloud_storage/              # Module Terraform pour Cloud Storage
│   ├── cloud_run/                  # Module Terraform pour Cloud Run + Dockerfile
│   └── load_balancer/              # Module Terraform pour le Load Balancer
├── get-cloud-run-ip.sh             # Script Bash pour récupérer l’IP publique
├── main.tf                         # Configuration principale Terraform
├── provider.tf                     # Configuration du provider et backend
├── variables.tf                    # Déclaration des variables Terraform
├── terraform.tfvars                # Valeurs par défaut des variables
├── outputs.tf                      # Outputs Terraform
└── README.md                       # Documentation du projet



---

## Guide d’Installation & Déploiement

### 1. Prérequis  
- Compte GCP avec facturation active  
- SDK `gcloud`, Terraform v1.x et Docker installés  

### 2. Configuration des Variables d’Environnement Infrastructure as Code (Terraform) 
```bash
export PROJECT_ID="devops-test-terraform-blue"
export REGION="europe-west1"
export TF_VAR_project_id=$PROJECT_ID
export TF_VAR_region=$REGION
export TF_VAR_bucket_name="my-static-files"
export TF_VAR_db_password="MotDePasseFort123!"


### 3. Infrastructure as Code (Terraform)

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

### 4. CI/CD Pipeline avec GitHub Actions:

Dans GitHub → Settings → Secrets, créez :

GCP_PROJECT_ID

GCP_REGION

GCP_SERVICE_ACCOUNT_KEY (clé JSON du service account)

Le workflow .github/workflows/ci-cd.yml fait :

Checkout du code

Authentification GCP (google-github-actions/auth@v2)

Build et push Docker avec Buildx (docker/build-push-action@v3)

Déploiement sur Cloud Run (google-github-actions/deploy-cloudrun@v1)

Result:
suphotio@ubuntu-s-1vcpu-512mb-10gb-nyc1-01:~/BLUE/devops-test-Blue/modules/cloud_run$ docker run -p 8080:8080 -e PORT=8080 php-fpm-app
[20-May-2025 22:57:35] NOTICE: fpm is running, pid 8
[20-May-2025 22:57:35] NOTICE: ready to handle connections
127.0.0.1 -  20/May/2025:22:58:18 +0000 "GET /app.php" 200


### 5. Récupération de l’IP Publique : 

./get-cloud-run-ip.sh dev
Resultat : 
suphotio@ubuntu-s-1vcpu-512mb-10gb-nyc1-01:~/BLUE/devops-test-Blue$ ./get-cloud-run-ip.sh dev
[2025-05-20 19:02:58] Démarrage du script pour l'environnement 'dev'
[2025-05-20 19:03:04] URL du service : https://mon-service-dev-364751985015.europe-west1.run.app
[2025-05-20 19:03:04] Adresse IP publique du service : 2600:1900:4245:200::

Adresse IP publique du service 'mon-service-dev' (dev) : 2600:1900:4245:200::

[2025-05-20 19:03:04] Script exécuté avec succès pour l'environnement 'dev'.

### Retours d’Expérience & Résolution de Problèmes

Attribution de roles/iam.serviceAccountUser pour actAs

roles/artifactregistry.writer pour le push Docker

Activation d’APIs

cloudresourcemanager, iam, run, artifactregistry

Erreur “denied: Unauthenticated request”

Correct credential helper Docker + rôle IAM

Terraform modulaire (modules réutilisables)

Pipelines GitHub Actions documentés et testés

Script Bash robuste avec journalisation et gestion d’erreurs


### Perspectives & Améliorations

Monitoring & Alerting : Cloud Monitoring, alertes 5xx/CPU

Sécurité : Secret Manager, Cloud Armor, OIDC sans clés JSON

Tests Automatisés : PHPUnit et couverture de code dans le pipeline

HA & DR : Multi-régions, backups Cloud SQL, stratégie DR dans dr.md

Documentation Automatique : intégration terraform-docs, diagrammes Mermaid

Extras : idées et expérimentations consignées dans extra.md

Ce projet, réalisé, démontre ma capacité à gérer de bout en bout un cycle DevOps : de la définition de l’infrastructure à son déploiement automatisé, en passant par la résolution proactive des problèmes et la documentation claire des solutions. J’aspire à mettre cette expertise et cette passion au service de votre équipe
