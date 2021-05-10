#!/bin/bash

# change to determined SOURCE & DESTINATION KeyVaults
SOURCE_KEYVAULT="keyvault_source"
DESTINATION_KEYVAULT="keyvault_destination"
 
SECRETS+=($(az keyvault secret list --vault-name $SOURCE_KEYVAULT --query "[].id" -o tsv))
 
for SECRET in "${SECRETS[@]}"; do
 
SECRETNAME=$(echo "$SECRET" | sed 's|.*/||')
 
SECRET_CHECK=$(az keyvault secret list --vault-name $DESTINATION_KEYVAULT --query "[?name=='$SECRETNAME']" -o tsv)
 
 
if [ -n "$SECRET_CHECK" ]
then
    echo "A secret with name $SECRETNAME already exists in $DESTINATION_KEYVAULT"
else
    echo "Copying $SECRETNAME to KeyVault: $DESTINATION_KEYVAULT"
    SECRET=$(az keyvault secret show --vault-name $SOURCE_KEYVAULT -n $SECRETNAME --query "value" -o tsv)
    az keyvault secret set --vault-name $DESTINATION_KEYVAULT -n $SECRETNAME --value "$SECRET" >/dev/null
fi
 
done