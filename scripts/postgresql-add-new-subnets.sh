#!/bin/bash

# POSTGRES_SQL
ENV="perftest"
SUBSCRIPTION_NAME_POSTGRES="SUBSCRIPTION_NAME_POSTGRES"

# VNET
SUBSCRIPTION_NAME_VNET="SUBSCRIPTION_NAME_VNET"
VNET_NAME="vnet"
VNET_RESOURCE_GROUP="vnet-rg"
SUBNET00="aks-00"
SUBNET01="aks-01"

# Sets to postgres account (required for az postgres server vnet-rule create as it requires --resource-group)
az account set -s $SUBSCRIPTION_NAME_POSTGRES

POSTGRES_SQL_LIST+=($(az postgres server list --subscription=$SUBSCRIPTION_NAME_POSTGRES --query "[?(contains(name,'$ENV'))].name" -o tsv | sort -u))

IFS=$'\n'
SUBNET_AKS=()
SUBNET_AKS+=("$(az network vnet subnet list --vnet-name $VNET_NAME --resource-group $VNET_RESOURCE_GROUP --subscription=$SUBSCRIPTION_NAME_VNET --query "[?(contains(name,'$SUBNET00'))].id" -o tsv)")
SUBNET_AKS+=("$(az network vnet subnet list --vnet-name $VNET_NAME --resource-group $VNET_RESOURCE_GROUP --subscription=$SUBSCRIPTION_NAME_VNET --query "[?(contains(name,'$SUBNET01'))].id" -o tsv)")


for SUBNET in "${SUBNET_AKS[@]}"; do

    for POSTGRES_SQL in "${POSTGRES_SQL_LIST[@]}"; do

    POST_SQL_ID="$(az postgres server list --subscription=$SUBSCRIPTION_NAME_POSTGRES --query "[?(contains(name,'$POSTGRES_SQL'))].id" -o tsv | sort -u)"
    RULE_CHECK="$(az postgres server vnet-rule list --ids $POST_SQL_ID --query "[].virtualNetworkSubnetId" -o tsv)"

        # Checks if $RULE_CHECK is not blank, if blank it is most likely postgresv11 DB that is deployed using the new module that uses private endpoint
        if [ -n "$RULE_CHECK" ]; then

            SUBNET_CHECK="$(az postgres server vnet-rule list --ids $POST_SQL_ID --query "[?contains(virtualNetworkSubnetId'$SUBNET')]" -o tsv)"

            POST_SQL_RG="$(az postgres server list --subscription=$SUBSCRIPTION_NAME_POSTGRES --query "[?(contains(name,'$POSTGRES_SQL'))].id" -o tsv | cut -f5 -d"/")"
            POST_SQL_NAME="$(az postgres server list --subscription=$SUBSCRIPTION_NAME_POSTGRES --query "[?(contains(name,'$POSTGRES_SQL'))].id" -o tsv | cut -f9 -d"/")"

            # Checks if subnet is already added
            if [ -z "$SUBNET_CHECK" ]; then
                                
                SUBNETNUMBER="$(echo "$SUBNET" | cut -f11 -d"/" | tr -dc '0-9')"
                
                echo "Adding Rule: cftaks-tf-aks$SUBNETNUMBER to PostgresDB: $POST_SQL_NAME"
                az postgres server vnet-rule create --name=cftaks-tf-aks$SUBNETNUMBER --subnet $SUBNET  --resource-group $POST_SQL_RG --server-name $POSTGRES_SQL

            else

                echo "Subnet $SUBNET is already added. Please review PostgresDB: $POST_SQL_NAME"

            fi 

        fi

    done

done