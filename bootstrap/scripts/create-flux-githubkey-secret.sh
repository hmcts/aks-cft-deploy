#!/bin/bash
set -e

VAULT_NAME=$8
NAMESPACE="admin"

if [ ! -f flux_pk ]; then
  az keyvault secret download \
    --file flux_pk \
    --name flux-github-private-key \
    --encoding ascii \
    --vault-name ${VAULT_NAME}
fi

kubectl -n ${NAMESPACE} delete secret flux-git-deploy || true

kubectl create secret generic flux-git-deploy \
  --from-file=identity=flux_pk \
  --namespace ${NAMESPACE}