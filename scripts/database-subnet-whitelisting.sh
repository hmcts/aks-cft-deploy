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
        subscription_id=$(az account show --subscription DCD-CFTAPPS-$env --query id -o tsv)
        az postgres server vnet-rule create --name=cft-aks-00 --subnet /subscriptions/$subscription_id/resourceGroups/cft-$env-network-rg/providers/Microsoft.Network/virtualNetworks/cft-$env-vnet/subnets/aks-00  --resource-group $rg --server-name $pg
        az postgres server vnet-rule create --name=cft-aks-01 --subnet /subscriptions/$subscription_id/resourceGroups/cft-$env-network-rg/providers/Microsoft.Network/virtualNetworks/cft-$env-vnet/subnets/aks-01  --resource-group $rg --server-name $pg
    fi;
  
   
done