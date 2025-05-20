#!/bin/bash

# Script pour récupérer l'adresse IP publique d'un service Cloud Run
# Utilisation : ./get-cloud-run-ip.sh [environnement]
# Exemple : ./get-cloud-run-ip.sh dev

#!/usr/bin/env bash
set -euo pipefail

# Usage: ./get-cloud-run-ip.sh [environnement]
usage() {
  echo "Usage: $0 [environnement]"
  echo "Exemple: $0 dev"
  exit 1
}

if [ "$#" -ne 1 ]; then
  usage
fi

ENV="$1"
LOG_FILE="get-cloud-run-ip.log"

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# Choix des variables selon l'environnement
case "$ENV" in
  dev)
    PROJECT_ID="devops-test-terraform-blue"
    REGION="europe-west1"
    SERVICE_NAME="mon-service-dev"
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

log "Démarrage du script pour l'environnement '$ENV'"

# Vérifications
if ! command -v gcloud &> /dev/null; then
  log "Erreur : gcloud n'est pas installé."
  exit 1
fi
if ! command -v nslookup &> /dev/null; then
  log "Erreur : nslookup n'est pas installé."
  exit 1
fi

# Configuration gcloud
gcloud config set project "$PROJECT_ID"       &>> "$LOG_FILE"
gcloud config set run/region "$REGION"        &>> "$LOG_FILE"

# Récupération de l’URL via `list` (URL toujours renseignée)
SERVICE_URL=$(gcloud run services list \
  --platform managed \
  --region "$REGION" \
  --filter="SERVICE:$SERVICE_NAME" \
  --format="value(URL)" ) || {
    log "Erreur : impossible de récupérer l’URL du service '$SERVICE_NAME'"
    exit 1
}
if [ -z "$SERVICE_URL" ]; then
  log "Erreur : service '$SERVICE_NAME' introuvable ou URL vide."
  exit 1
fi
log "URL du service : $SERVICE_URL"

# Extraction du hostname et résolution DNS
HOSTNAME=${SERVICE_URL#https://}
IP_ADDRESS=$(nslookup "$HOSTNAME" \
  | awk '/^Address: / { print $2 }' \
  | tail -n1 ) || {
    log "Erreur : impossible de résoudre l’IP pour '$HOSTNAME'"
    exit 1
}
if [ -z "$IP_ADDRESS" ]; then
  log "Erreur : aucune IP trouvée pour '$HOSTNAME'"
  exit 1
fi
log "Adresse IP publique du service : $IP_ADDRESS"

# Affichage final
echo
echo "Adresse IP publique du service '$SERVICE_NAME' ($ENV) : $IP_ADDRESS"
echo

log "Script exécuté avec succès pour l'environnement '$ENV'."

