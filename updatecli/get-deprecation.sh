#!/usr/bin/env bash

environment="$CURRENT_ITER_ENVIRONMENT"
aks_name=`yq ".environments.$environment.aks_name" ./updatecli/values.github-action.yaml`
aks_resource_group=`yq ".environments.$environment.aks_resource_group" ./updatecli/values.github-action.yaml`
aks_subscription=`yq ".environments.$environment.aks_subscription" ./updatecli/values.github-action.yaml`

# get kubelogin
if ! kubelogin --version  &> /dev/null
then
    wget -q https://github.com/Azure/kubelogin/releases/download/v0.0.9/kubelogin-linux-amd64.zip
    unzip kubelogin-linux-amd64.zip &> /dev/null
    sudo mv bin/linux_amd64/kubelogin /usr/bin
    kubelogin convert-kubeconfig -l azurecli
fi

az account set -s "${aks_subscription}"

az aks get-credentials \
    --resource-group "${aks_resource_group}"\
    --name "${aks_name}"\
    --admin

current_version=$(az aks show  --resource-group "${aks_resource_group}" --name "${aks_name}" | grep 'currentKubernetesVersion' | grep -Eo '[0-9].[0-9][0-9]')
aks_version=$(echo "$current_version + 0.01" | bc)

## Comment body
echo "## (${aks_name})"

echo '```'
pluto detect-helm -o wide --target-versions k8s=v${aks_version}
echo '```'

echo -e "\n---\n"
