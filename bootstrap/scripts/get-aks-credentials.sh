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

# Non-admin kubeconfig authenticates via AAD exec plugin; kubelogin converts it to use the pipeline's service principal
# client-id/tenant-id must be passed as flags (kubelogin only bakes these into the kubeconfig from flags or pre-existing
# exec args, not from env vars); the secret is deliberately left out of the kubeconfig, read from AAD_SERVICE_PRINCIPAL_CLIENT_SECRET at token-fetch time
if [[ "${ENVIRONMENT}" == "sbox" ]]; then
    : "${SYSTEM_ACCESSTOKEN:?SYSTEM_ACCESSTOKEN is required}"
    : "${SYSTEM_OIDCREQUESTURI:?SYSTEM_OIDCREQUESTURI is required}"
    : "${AZURESUBSCRIPTION_TENANT_ID:?Service connection tenant ID is required}"
    : "${AZURESUBSCRIPTION_CLIENT_ID:?Service connection client ID is required}"
    : "${AZURESUBSCRIPTION_SERVICE_CONNECTION_ID:?Service connection ID is required}"

    kubelogin convert-kubeconfig \
        --login azurepipelines \
        --tenant-id "${AZURESUBSCRIPTION_TENANT_ID}" \
        --client-id "${AZURESUBSCRIPTION_CLIENT_ID}" \
        --azure-pipelines-service-connection-id "${AZURESUBSCRIPTION_SERVICE_CONNECTION_ID}" \
        --disable-environment-override
else
    kubelogin convert-kubeconfig \
        -l spn \
        --client-id "${AAD_SERVICE_PRINCIPAL_CLIENT_ID}" \
        --tenant-id "${tenantId}"
fi