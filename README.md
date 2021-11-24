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
        
    3) Managed Identity
        a) Configures relevant managed identities and permissions for AKS deployment

    3) Deploy AKS Clusters
        a) Builds AKS clusters (determines if 00 or 01/01 by parameter.cluster) with default linux node pool
        b) Adds additional windows node pool[Optional]
        
    4) Bootstrap
        a) Creates sshkeys for flux if required
        b) Implements RBAC
        c) Install flux and helm operator
        d) Create neuvector azure file share
        e) Generate sealed secrets [optional]
        f) Registers cluster to Dynatrace [Specific clusters only]
        
    5) Destroy
        a) Optional to perform terraform destroy for AKS


## Scripts Information

As CFT is currently configured via ARM templates and an active solution, some additional scripts have been created to assist with moving from ARM to Terraform
    
    1) scripts/key-vault-copy-filedownload.sh - Copies KeyVault secrets from currently used cft KeyVault to new KeyVault that is mentioned in Genesis stage 

    2)  scripts/postgresql-add-new-subnets.sh - Assigns the new aks00/01 subnets to all relevant postgresql databases for the specific environment, such as perftest, aat etc. 
    - Some logic built into script
      - If connection security has no subnets, it doesn't add these subnets - most likely been upgraded to v11 which uses private endpoints
      - Checks if either of the subnets have been deployed already, as part of migration process is to update hmcts/cnp-database-subnet-whitelisting repo
      