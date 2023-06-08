#!/usr/bin/env bash
set -e

PARAM_LIST=( PROJECT SERVICE ENVIRONMENT KEYVAULT SUBSCRIPTION_NAME CLUSTER_NAMES COMMAND AKS_KEYVAULT TERRAFORMSUBSCRIPTIONID)

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


# Make sure the 9 arguments are passed
if [[ $# -lt 9 ]]
then
    usage
fi

echo "Params: $*"

chmod +x scripts/get-aks-credentials.sh
chmod +x scripts/create-custom-namespaces.sh
chmod +x scripts/create-cluster-admins.sh
chmod +x scripts/create-flux-githubkey-secret.sh
chmod +x scripts/install-flux.sh
chmod +x scripts/create-neuvector-azure-file-share.sh
chmod +x scripts/cleanup-sshkeys.sh

project=${1}
env=${3}
if [[ "${6}" == "All" ]]; then
  echo "Checking for available clusters"
  clusters=$(az aks list --output tsv --query '[].name')
  echo -e "Clusters found:\n${clusters}"
  cluster_numbers=$(echo "${clusters}" | sed -n "s/${project}-${env}-\([0-9][0-9]\)-aks/\1/p" )
else
  cluster_numbers=${6}
fi


for cluster in ${cluster_numbers}; do
  set -- "${@:1:5}" "$cluster" "${@:7:8}"

  echo "################################"
  echo -e "Starting Deployment on ${project}-${env}-${cluster}-aks\n"

  ./scripts/get-aks-credentials.sh "$@" || error_exit "ERROR: Unable to get AKS credentials"
  ./scripts/create-custom-namespaces.sh "$@" || error_exit "ERROR: Unable to create custom namespaces"
  ./scripts/create-cluster-admins.sh "$@" || error_exit "ERROR: Unable to create cluster admins"
  ./scripts/create-flux-githubkey-secret.sh "$@"|| error_exit "ERROR: Unable to create flux githubkey secret"
  ./scripts/install-flux.sh "$@"|| error_exit "ERROR: Unable to install flux"
  [[ $6 =~ ^(aat|ithc|perftest|prod)$ ]] && (./scripts/create-neuvector-azure-file-share.sh "$@"|| error_exit "ERROR: Unable to create Neuvector Azure File Shares")
  echo "Cleanup"
  ./scripts/cleanup-sshkeys.sh "$@" || error_exit "ERROR: Unable to Cleanup"

  echo "Deployment Complete for ${project}-${env}-${cluster}-aks"
  echo "################################"
done
