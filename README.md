# cft-aks-deploy

Terraform code to deploy CFT AKS Cluster and underlying infrastructure.

## Pipeline trigger and manual validation rules

PR auto-runs are intentionally path-filtered to reduce noise and cost. Only changes under the paths configured in pipeline trigger rules will auto-start a PR pipeline.

If your PR changes code outside those paths but still needs validation, run pipeline manually and choose required parameters.

Use manual runs when testing:

1) Shared scripts or docs that influence operator behavior but do not match PR trigger paths.
2) Non-functional changes that still require confidence checks before merge.
3) Targeted cluster execution for validation using the cluster parameter.

PR environment detection now fails fast. If target branch fetch or git checkout detection fails, PreCheck fails immediately instead of silently running sbox-only.

## Agent pool selection

No implicit default pool is used. All stages now resolve pool from the agentPoolType parameter:

1) hosted -> vmImage from hostedVmImage variable.
2) self-hosted -> pool name from selfHostedAgentPool variable.

Purpose: keep behavior predictable across users and queues, and avoid accidental routing to a project/org default pool.

## Warning

When merging to this repo please check your plans for AKS version changes.

If you see a change similar to 1.34.X -> 1.34 this will bring the cluster into a failed state when applied as it rebuilds the nodes and the PDBs in the cluster will block this.

When applying with a change like this in the plan you will need to delete the PDBs with allowed disruptions set to 0 from the cluster as it applies.

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
        c) Updates OIDC issuer URL in flux
        d) Install flux and helm operator
        e) Create neuvector azure file share
        f) Generate sealed secrets [optional]

## Scripts Information

As CFT is currently configured via ARM templates and an active solution, some additional scripts have been created to assist with moving from ARM to Terraform

    1) scripts/key-vault-copy-filedownload.sh - Copies KeyVault secrets from currently used cft KeyVault to new KeyVault that is mentioned in Genesis stage 

    2)  scripts/postgresql-add-new-subnets.sh - Assigns the new aks00/01 subnets to all relevant postgresql databases for the specific environment, such as perftest, aat etc. 
    - Some logic built into script
      - If connection security has no subnets, it doesn't add these subnets - most likely been upgraded to v11 which uses private endpoints
      - Checks if either of the subnets have been deployed already, as part of migration process is to update hmcts/cnp-database-subnet-whitelisting repo
