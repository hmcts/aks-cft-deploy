#!/bin/bash

set -e

# Example: az aks stop --name myAKSCluster --resource-group myResourceGroup 
# Real life example: az aks stop --name cft-sbox-00-aks --resource-group cft-sbox-00-rg

echo Cluster name is $1 and Resource group name is $2

az aks stop --name $1 --resource-group $2