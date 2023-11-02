enable_debug = "true"

network_address_space                  = "10.10.128.0/18"
aks_00_subnet_cidr_blocks              = "10.10.128.0/20"
aks_01_subnet_cidr_blocks              = "10.10.144.0/20"
iaas_subnet_cidr_blocks                = "10.10.160.0/24"
application_gateway_subnet_cidr_blocks = "10.10.161.0/25"
postgresql_subnet_cidr_blocks          = "10.10.168.0/25"

additional_subnets = [
  {
    name           = "api-management"
    address_prefix = "10.10.161.128/25"
  },
  {
    name           = "private-endpoints"
    address_prefix = "10.10.164.0/22"
  },
  {
    name           = "postgres-expanded"
    address_prefix = "10.10.172.0/22"
  }
]

private_dns_subscription = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_zones = [
  "aat.platform.hmcts.net",
  "service.core-compute-aat.internal",
  "service.core-compute-idam-aat.internal",
  "service.core-compute-idam-aat2.internal",
  "preview.platform.hmcts.net",
  "service.core-compute-preview.internal",
  "service.core-compute-idam-preview.internal",
  "staging.platform.hmcts.net"
]

hub = "prod"

additional_routes = [
  {
    name                   = "preview"
    address_prefix         = "10.12.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft_preview_vnet"
    address_prefix         = "10.48.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft_preview_vnet_new"
    address_prefix         = "10.101.128.0/17"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "10_0_0_0"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "172_16_0_0"
    address_prefix         = "172.16.0.0/12"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "192_168_0_0"
    address_prefix         = "192.168.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "mcol_app_nle_subnet"
    address_prefix         = "10.25.248.32/27"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "ss-dev-vnet"
    address_prefix         = "10.145.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_application_gateway = [
  {
    name                   = "core_infra_vnet_idam_aat2"
    address_prefix         = "10.103.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "core_infra_vnet_idam_aat"
    address_prefix         = "10.98.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "cft-ptl-vnet"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "core_preview_vnet"
    address_prefix         = "10.12.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft_preview_vnet"
    address_prefix         = "10.48.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft_preview_vnet_new"
    address_prefix         = "10.101.128.0/17"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core-infra-vnet-aat"
    address_prefix         = "10.96.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "ss-dev-vnet"
    address_prefix         = "10.145.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "core_cftptl_intvsc_vnet"
    address_prefix         = "10.10.64.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  }
]

additional_routes_coreinfra = [
  {
    name                   = "cft-aks-aat-vnet"
    address_prefix         = "10.10.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "preview-00"
    address_prefix         = "10.48.128.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "preview-01"
    address_prefix         = "10.48.144.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft-preview-00"
    address_prefix         = "10.101.128.0/19"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft-preview-01"
    address_prefix         = "10.101.160.0/19"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cftptl"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "soc_prod"
    address_prefix         = "10.146.0.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  }
]

coreinfra_subnets = [
  {
    name = "elasticsearch"
  },
  {
    name = "core-infra-subnet-0-aat"
  },
  {
    name = "core-infra-subnet-1-aat"
  },
  {
    name = "scan-storage"
  },
  {
    name = "core-infra-subnet-apimgmt-aat"
  }
]
