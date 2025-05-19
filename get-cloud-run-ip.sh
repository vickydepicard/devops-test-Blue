#!/bin/bash

# Script pour récupérer l'adresse IP publique d'un service Cloud Run
# Utilisation : ./get-cloud-run-ip.sh [environnement]
# Exemple : ./get-cloud-run-ip.sh dev

set -euo pipefail

# Fonction d'affichage de l'usage
usage() {
  echo "Usage: $0 [environnement]"
  echo "Exemple: $0 dev"
  exit 1
}

# Vérification du nombre d'arguments
if [ "$#" -ne 1 ]; then
  usage
fi

# Récupération de l'argument d'environnement
ENV="$1"

# Définition des variables en fonction de l'environnement
case "$ENV" in
  dev)
    PROJECT_ID="devops-test-terraform-blue"
    REGION="europe-west1"
    SERVICE_NAME="mon-service-dev"  # Remplacez par le nom réel de votre service
    ;;
  staging)
    PROJECT_ID="mon-projet-staging"
    REGION="europe-west1"
    SERVICE_NAME="mon-service-staging"
    ;;
  prod)
    PROJECT_ID="mon-projet-prod"
    REGION="europe-west1"
    SERVICE_NAME="mon-service-prod"
    ;;
  *)
    echo "Environnement inconnu: $ENV"
    usage
    ;;
esac

# Fichier de log
LOG_FILE="get-cloud-run-ip.log"

# Fonction de journalisation
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "Démarrage du script pour l'environnement '$ENV'"

# Vérification de la présence de gcloud
if ! command -v gcloud &> /dev/null; then
  log "Erreur : gcloud n'est pas installé. Veuillez l'installer et vous authentifier."
  exit 1
fi

# Configuration du projet et de la région
gcloud config set project "$PROJECT_ID" &>> "$LOG_FILE"
gcloud config set run/region "$REGION" &>> "$LOG_FILE"

# Vérification de l'existence du service
if ! gcloud run services describe "$SERVICE_NAME" --platform managed --region "$REGION" &> /dev/null; then
  log "Erreur : le service '$SERVICE_NAME' n'existe pas dans le projet '$PROJECT_ID' et la région '$REGION'."
  exit 1
fi

# Récupération de l'URL du service Cloud Run
SERVICE_URL=$(gcloud run services describe "$SERVICE_NAME" --platform managed --region "$REGION" --format='value(status.url)' 2>> "$LOG_FILE") || {
  log "Erreur : impossible de récupérer l'URL du service '$SERVICE_NAME'"
  exit 1
}

log "URL du service : $SERVICE_URL"

# Extraction du nom d'hôte à partir de l'URL
HOSTNAME=$(echo "$SERVICE_URL" | sed 's|https://||')

# Récupération de l'adresse IP publique via nslookup
IP_ADDRESS=$(nslookup "$HOSTNAME" | awk '/^Address: / { print $2 }' | tail -n1) || {
  log "Erreur : impossible de résoudre l'adresse IP pour '$SERVICE_URL'"
  exit 1
}

# Vérification de la présence d'une adresse IP
if [ -z "$IP_ADDRESS" ]; then
  log "Erreur : aucune adresse IP trouvée pour '$SERVICE_URL'"
  exit 1
fi

log "Adresse IP publique du service : $IP_ADDRESS"

echo "Adresse IP publique du service '$SERVICE_NAME' ($ENV) : $IP_ADDRESS"

log "Script exécuté avec succès pour l'environnement '$ENV'."

