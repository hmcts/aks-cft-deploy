#!/bin/bash
set -e

ENV=$3

if [ $ENV = "perftest" ]; then
ENV="test"
elif [ $ENV = "aat" ]; then
ENV="stg"
elif [ $ENV = "preview" ]; then
ENV="dev"
fi

VAULT_NAME=$8
STORAGE_ACCOUNT_NAME=cftapps$ENV
RESOURCE_GROUP_NAME=core-infra-$ENV-rg 

#Create an azure file share for NeuVector persistent storage
CONNECTION_STRING=$(az storage account show-connection-string -n ${STORAGE_ACCOUNT_NAME} -g ${RESOURCE_GROUP_NAME} --query 'connectionString' -o tsv)
az storage share create --name neuvector-data-00 --quota 1 --connection-string ${CONNECTION_STRING}
az storage share create --name neuvector-data-01 --quota 1 --connection-string ${CONNECTION_STRING}

STORAGE_ACCOUNT_KEY=$(az storage account keys list --account-name ${STORAGE_ACCOUNT_NAME} --resource-group ${RESOURCE_GROUP_NAME} --query [0].value -o tsv)

az keyvault secret set \
 --vault-name ${VAULT_NAME} \
 --name "storage-account-key" \
 --value ${STORAGE_ACCOUNT_KEY} \
 --description "Infra storage account key"