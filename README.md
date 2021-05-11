# cft-aks-deploy
Terraform code to deploy CFT AKS Cluster and underlying infrastructure.

## Following resources are being deployed in each stage of the pipeline

    1) Genesis
        a) Creates a resource group called "genesis-rg"
        b) Creates a KV and update access policy
        
    2) Network
        a) Creates a resource group
        b) Creates Vnet, subnets & route tables
        c) Peers with hub and vpn vnets
        d) Updates private DNS
        
    3) AKS00
        a) Builds AKS cluster with default linux node pool
        b) Adds additional windows node pool

    3) AKS01
        a) Builds AKS cluster with default linux node pool
        b) Adds additional windows node pool
        
    4) Bootstrap
        a) Creates sshkeys for flux if required
        b) Implements RBAC
        c) Install flux and helm operator
        
    5) Destroy
        a) Optional to perform terraform destroy for AKS


## Scripts Information

As CFT is currently configured via ARM templates and an active solution, some additional scripts have been created to assist with moving from ARM to Terraform
    
    1) scripts/key-vault-copy-filedownload.sh - Copies KeyVault secrets from currently used cft KeyVault to new KeyVault that is mentioned in Genesis stage 