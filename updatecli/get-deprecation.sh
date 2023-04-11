#!/usr/bin/env bash

environment="$CURRENT_ITER_ENVIRONMENT"
aks_name=`yq ".environments.$environment.aks_name" ./updatecli/values.github-action.yaml`
aks_resource_group=`yq ".environments.$environment.aks_resource_group" ./updatecli/values.github-action.yaml`
aks_subscription=`yq ".environments.$environment.aks_subscription" ./updatecli/values.github-action.yaml`

set -x 
{
echo "Before-------"
echo "${aks_name}"
echo "${aks_resource_group}"
echo "${aks_subscription}"
echo "${environment}"

az account set -s "${aks_subscription}"

echo "Trying cluster ${aks_name} in RG ${aks_resource_group}"
az aks get-credentials \
    --resource-group "${aks_resource_group}"\
    --name "${aks_name}" --admin
$(kubectl get pods)
pluto detect-helm -owide
}