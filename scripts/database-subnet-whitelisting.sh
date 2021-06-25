set -e

env="perftest"

POSTGRES_LIST=$(az postgres server list --subscription="DCD-CNP-QA" --query "[?(contains(name,'$env'))].name" -o tsv | sort -u)

for pg in ${POSTGRES_LIST[@]}
do
    case $pg in
    
    *"-idam"*)
        rg=${pg//-idam/-data-idam}
        ;;

    *"-$env-clone"*)
        rg=${pg//-$env-clone/-data-$env}
        ;;
    
    *"-$env"*)
        rg=${pg//-$env/-data-$env}
        ;;

    esac
    if [ "$(az postgres server vnet-rule list --resource-group $rg --server-name $pg -o tsv)" ]; 
    then 
        echo "Skipping this as $pg already has vnet rules"; 
    else 
        echo "Creating vnet rules for $pg"; 
        az postgres server vnet-rule create --name=cft-aks-00 --subnet /subscriptions/8a07fdcd-6abd-48b3-ad88-ff737a4b9e3c/resourceGroups/cft-test-network-rg/providers/Microsoft.Network/virtualNetworks/cft-test-vnet/subnets/aks-00  --resource-group $rg --server-name $pg
        az postgres server vnet-rule create --name=cft-aks-01 --subnet /subscriptions/8a07fdcd-6abd-48b3-ad88-ff737a4b9e3c/resourceGroups/cft-test-network-rg/providers/Microsoft.Network/virtualNetworks/cft-test-vnet/subnets/aks-01  --resource-group $rg --server-name $pg
    fi;
  
   
done