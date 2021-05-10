#!/bin/bash
set -e

VAULT_NAME=${4}
VERSION="1.10.3"
NAMESPACE="admin"

az keyvault secret download \
  --file sealed-secrets-pki.yaml \
  --name sealed-secrets-pki \
  --encoding ascii \
  --vault-name ${VAULT_NAME}

kubectl apply -f sealed-secrets-pki.yaml

helm repo add hmctspublic https://hmctspublic.azurecr.io/helm/v1/repo
helm upgrade sealed-secrets hmctspublic/sealed-secrets --version 1.12.0 --install --namespace ${NAMESPACE} \
     -f  deployments/sealed-secrets/values.yaml --set secretName=sealed-secrets-pki --wait \
