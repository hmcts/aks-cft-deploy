#!/bin/bash

set -e

CLUSTER_NAME='cft-$(environment)-0$(clusters)-aks'
RESOURCE_GROUP_NAME='cft-$(environment)-0$(clusters)-rg'

# Example: az aks stop --name myAKSCluster --resource-group myResourceGroup 
# Real life example: az aks stop --name cft-sbox-00-aks --resource-group cft-sbox-00-rg

echo Cluster name is $CLUSTER_NAME and Resource group name is $RESOURCE_GROUP_NAME

az aks stop --name ${CLUSTER_NAME} --resource-group ${RESOURCE_GROUP_NAME}

