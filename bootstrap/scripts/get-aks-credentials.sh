#!/usr/bin/env bash
set -e

PROJECT="${1}"
SERVICE="${2}"
ENVIRONMENT="${3}"
CLUSTER_NAME="${6}"
TERRAFORMSUBSCRIPTIONID="${9}"

echo  "Get aks credentials "

az account set --subscription ${TERRAFORMSUBSCRIPTIONID}
az aks get-credentials \
    --resource-group "${PROJECT}"-"${ENVIRONMENT}"-"${CLUSTER_NAME}"-rg \
    --name "${PROJECT}"-"${ENVIRONMENT}"-"${CLUSTER_NAME}"-"${SERVICE}" \
    --overwrite-existing

# Non-admin kubeconfig authenticates via AAD exec plugin; kubelogin converts it to reuse the pipeline's az cli login
kubelogin convert-kubeconfig -l azurecli