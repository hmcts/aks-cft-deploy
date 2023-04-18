#!/usr/bin/env bash
set -e

az_keyvault_name="${8}"
AGENT_BUILDDIRECTORY=/tmp


private_key="$(az keyvault secret list --vault-name ${az_keyvault_name} --query "[?name=='flux-github-private-key'].name" -o tsv)"
public_key="$(az keyvault secret list --vault-name ${az_keyvault_name} --query "[?name=='flux-github-public-key'].name" -o tsv)"
if [[ -z $public_key ]] || [[ -z $private_key ]] 
    then
            echo "SSHKey Setup"
            ssh-keygen -t ed25519 -f $AGENT_BUILDDIRECTORY/flux-ssh-git-key -q -P "" -C ""
            az keyvault secret set --name flux-github-private-key --vault-name ${az_keyvault_name} --file $AGENT_BUILDDIRECTORY/flux-ssh-git-key
            az keyvault secret set --name flux-github-public-key --vault-name ${az_keyvault_name} --file $AGENT_BUILDDIRECTORY/flux-ssh-git-key.pub
    else
            echo "SSHKey Download"
            az keyvault secret download --name flux-github-private-key --vault-name ${az_keyvault_name} --file $AGENT_BUILDDIRECTORY/flux-ssh-git-key --encoding ascii
            az keyvault secret download --name flux-github-public-key --vault-name ${az_keyvault_name} --file $AGENT_BUILDDIRECTORY/flux-ssh-git-key.pub --encoding ascii
    fi