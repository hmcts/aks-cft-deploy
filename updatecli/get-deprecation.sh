#!/usr/bin/env bash


environment="$CURRENT_ITER_ENVIRONMENT"
aks_name=`yq ".environments.$environment.aks_name" ./updatecli/values.github-action.yaml`
aks_resource_group=`yq ".environments.$environment.aks_resource_group" ./updatecli/values.github-action.yaml`
aks_subscription=`yq ".environments.$environment.aks_subscription" ./updatecli/values.github-action.yaml`
az account set -s "${aks_subscription}"

aks_name=$1
aks_resource_group=$2
aks_subscription=$3
environment=$4

set -x

{
echo "Trying cluster ${aks_name} in RG ${aks_resource_group}"
az aks get-credentials \
    --resource-group "${aks_resource_group}"\
    --name "${aks_name}" --admin
$(kubectl get pods)
pluto detect-helm -owide
}