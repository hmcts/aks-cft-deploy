#!/bin/bash

# change to determined SOURCE & DESTINATION KeyVaults
SOURCE_KEYVAULT="SOURCE_KEYVAULT"
DESTINATION_KEYVAULT="DESTINATION_KEYVAULT"
 
SECRETS+=($(az keyvault secret list --vault-name $SOURCE_KEYVAULT --query "[].id" -o tsv))
 
for SECRET in "${SECRETS[@]}"; do
 
SECRETNAME=$(echo "$SECRET" | sed 's|.*/||')
 
SECRET_CHECK=$(az keyvault secret list --vault-name $DESTINATION_KEYVAULT --query "[?name=='$SECRETNAME']" -o tsv)
 
    # echo "Copying $SECRETNAME to KeyVault: $DESTINATION_KEYVAULT"
    
    # az keyvault secret download --file "secretfile" --vault-name $SOURCE_KEYVAULT -n $SECRETNAME
    # FILE_ENCODING=$(az keyvault secret show --vault-name $SOURCE_KEYVAULT -n $SECRETNAME --query "tags" -o tsv)

    # if [ "$FILE_ENCODING" == "ascii" ] || [ "$FILE_ENCODING" == "utf-8" ]
    # then
    # az keyvault secret set --name $SECRETNAME --vault-name $DESTINATION_KEYVAULT --file "secretfile" --encoding $FILE_ENCODING >/dev/null
    # else 
    # az keyvault secret set --name $SECRETNAME --vault-name $DESTINATION_KEYVAULT --file "secretfile" >/dev/null 
    # fi 
    # rm secretfile

if [ -n "$SECRET_CHECK" ]
then
    echo "A secret with name $SECRETNAME already exists in $DESTINATION_KEYVAULT"
else

    echo "Copying $SECRETNAME to KeyVault: $DESTINATION_KEYVAULT"
    
    az keyvault secret download --file "secretfile" --vault-name $SOURCE_KEYVAULT -n $SECRETNAME
    FILE_ENCODING=$(az keyvault secret show --vault-name $SOURCE_KEYVAULT -n $SECRETNAME --query "tags" -o tsv)
    
    if [ "$FILE_ENCODING" == "ascii" ] || [ "$FILE_ENCODING" == "utf-8" ]
    then
    az keyvault secret set --name $SECRETNAME --vault-name $DESTINATION_KEYVAULT --file "secretfile" --encoding $FILE_ENCODING >/dev/null
    else 
    az keyvault secret set --name $SECRETNAME --vault-name $DESTINATION_KEYVAULT --file "secretfile" >/dev/null 
    fi 
    rm secretfile

fi
 
done