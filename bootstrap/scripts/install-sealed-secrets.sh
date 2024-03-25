#!/bin/bash
set -e

VAULT_NAME=${8}
VERSION="2.1.6"
NAMESPACE="admin"

if [ ! -f sealed-secrets-pki.yaml ]; then
  az keyvault secret download \
    --file sealed-secrets-pki.yaml \
    --name sealed-secrets-pki \
    --encoding ascii \
    --vault-name $VAULT_NAME
fi

kubectl apply -f sealed-secrets-pki.yaml

helm repo add bitnami-labs https://bitnami-labs.github.io/sealed-secrets/
helm upgrade sealed-secrets bitnami-labs/sealed-secrets --version ${VERSION} --install --namespace ${NAMESPACE} \
     -f  deployments/sealed-secrets/values.yaml --set secretName=sealed-secrets-pki --wait \