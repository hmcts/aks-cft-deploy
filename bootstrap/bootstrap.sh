#!/usr/bin/env bash
set -e

PARAM_LIST=( PROJECT SERVICE ENVIRONMENT KEYVAULT SUBSCRIPTION_NAME CLUSTER_NAME COMMAND AKS_KEYVAULT )
############################################################
# Functions
############################################################

function usage() {
    echo ""
    echo "$0 ${PARAM_LIST[*]}"
    exit 0
}

function error_exit {
	echo "$1" 1>&2
  echo "Stopping..."
  #cleanup
	exit 1
}

############################################################

# Make sure they 7 arguments are passed
if [[ $# -lt 7 ]]
then
    usage
fi

chmod +x get-aks-credentials.sh
chmod +x create-custom-namespaces.sh
chmod +x create-cluster-admins.sh
chmod +x install-sealed-secrets.sh
chmod +x create-flux-githubkey-secret.sh
chmod +x install-flux.sh

echo "Starting Deployment"
./get-aks-credentials.sh "$@" || error_exit "ERROR: Unable to get AKS credentials"
./create-custom-namespaces.sh "$@" || error_exit "ERROR: Unable to create custom namespaces"
./create-cluster-admins.sh "$@" || error_exit "ERROR: Unable to create cluster admins"
./install-sealed-secrets.sh "$@"|| error_exit "ERROR: Unable to install sealed secrets"
./create-flux-githubkey-secret.sh "$@"|| error_exit "ERROR: Unable to create flux githubkey secret"
./install-flux.sh "$@"|| error_exit "ERROR: Unable to install flux"
# echo "Deployment Complete"