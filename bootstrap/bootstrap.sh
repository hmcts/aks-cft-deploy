#!/usr/bin/env bash
set -e

PARAM_LIST=( PROJECT SERVICE ENVIRONMENT KEYVAULT SUBSCRIPTION_NAME CLUSTER_NAME COMMAND AKS_KEYVAULT )

function usage() {
    echo ""
    echo "$0 ${PARAM_LIST[*]}"
    exit 0
}

function error_exit {
	echo "$1" 1>&2
  echo "Stopping..."
	exit 1
}


# Make sure the 8 arguments are passed
if [[ $# -lt 8 ]]
then
    usage
fi

chmod +x scripts/get-aks-credentials.sh
chmod +x scripts/create-custom-namespaces.sh
chmod +x scripts/create-cluster-admins.sh
chmod +x scripts/create-developer-roles.sh
chmod +x scripts/install-sealed-secrets.sh
chmod +x scripts/create-flux-githubkey-secret.sh
chmod +x scripts/install-flux.sh

echo "Starting Deployment"
./scripts/get-aks-credentials.sh "$@" || error_exit "ERROR: Unable to get AKS credentials"
./scripts/create-custom-namespaces.sh "$@" || error_exit "ERROR: Unable to create custom namespaces"
./scripts/create-cluster-admins.sh "$@" || error_exit "ERROR: Unable to create cluster admins"
./scripts/create-developer-roles.sh "$@" || error_exit "ERROR: Unable to create developer roles"
./scripts/install-sealed-secrets.sh "$@"|| error_exit "ERROR: Unable to install sealed secrets"
./scripts/create-flux-githubkey-secret.sh "$@"|| error_exit "ERROR: Unable to create flux githubkey secret"
./scripts/install-flux.sh "$@"|| error_exit "ERROR: Unable to install flux"
[ $9 == "true" ] && echo "IT WORKS" || error_exit "ERROR: Unable to generate sealed secrets"
# [ $9 == "true" ] &&  ./scripts/generate-sealed-secrets-pki.sh "$@"|| error_exit "ERROR: Unable to generate sealed secrets"
echo "Deployment Complete"