#!/bin/bash
set -e

VAULT_NAME=${8}
VERSION="1.10.3"
NAMESPACE="admin"

if [ ! -f sealed-secrets-pki.yaml ]; then
  az keyvault secret download \
    --file sealed-secrets-pki.yaml \
    --name sealed-secrets-pki \
    --encoding ascii \
    --vault-name $VAULT_NAME
fi

kubectl apply -f sealed-secrets-pki.yaml

helm repo add hmctspublic https://hmctspublic.azurecr.io/helm/v1/repo
helm upgrade sealed-secrets hmctspublic/sealed-secrets --version 2.0.0 --install --namespace ${NAMESPACE} \
     -f  deployments/sealed-secrets/values.yaml --set secretName=sealed-secrets-pki --wait \
