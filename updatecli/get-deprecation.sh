#!/usr/bin/env bash


environment="$CURRENT_ITER_ENVIRONMENT"
aks_name=`yq ".environments.$environment.aks_name" ./updatecli/values.github-action.yaml`
aks_resource_group=`yq ".environments.$environment.aks_resource_group" ./updatecli/values.github-action.yaml`
az account set $aks_subscription

aks_name=$1
aks_resource_group=$2
aks_subscription=$3
environment=$4

set -x

{
printf "\n\nTrying cluster $aks_name $aks_resource_group\n"
az aks get-credentials \
    --resource-group $aks_resource_group \
    --name $aks_name --admin
$(kubectl get pods)
pluto detect-helm -owide
}