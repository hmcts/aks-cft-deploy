#!/bin/bash
set -e

PROJECT="${1}"
SERVICE="${2}"
ENVIRONMENT="${3}"
CLUSTER_NAME="${6}"

echo "Disable Application Insights on Cluster"

az account set --subscription $SUBSCRIPTION_NAME

az aks disable-addons -a monitoring -n "${PROJECT}"-"${ENVIRONMENT}"-"${CLUSTER_NAME}"-"${SERVICE}" -g "${PROJECT}"-"${ENVIRONMENT}"-"${CLUSTER_NAME}"-rg