enable_debug = "true"

network_address_space                  = "10.101.128.0/17"
aks_00_subnet_cidr_blocks              = "10.101.128.0/19"
aks_01_subnet_cidr_blocks              = "10.101.160.0/19"
iaas_subnet_cidr_blocks                = "10.101.192.0/24"
application_gateway_subnet_cidr_blocks = "10.101.193.0/25"
postgresql_subnet_cidr_blocks          = "10.101.200.0/25"
postgresql_subnet_expanded_cidr_blocks = "10.101.202.0/23"

additional_subnets = [
  {
    name           = "api-management"
    address_prefix = "10.101.193.128/25"
  },
  {
    name           = "private-endpoints"
    address_prefix = "10.101.196.0/22"
  },
]

private_dns_subscription = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_zones = [
  "preview.platform.hmcts.net",
  "service.core-compute-preview.internal",
  "service.core-compute-idam-preview.internal",
  "aat.platform.hmcts.net",
  "service.core-compute-aat.internal",
  "service.core-compute-idam-aat.internal",
  "service.core-compute-idam-aat2.internal"
]

hub = "nonprod"

additional_routes = [
  {
    name                   = "10_0_0_0"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "172_16_0_0"
    address_prefix         = "172.16.0.0/12"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "192_168_0_0"
    address_prefix         = "192.168.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_application_gateway = [
  {
    name                   = "core_infra_vnet_idam_preview"
    address_prefix         = "10.97.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core_infra_subnet_mgmtpreview"
    address_prefix         = "10.97.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft-ptl-vnet"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_coreinfra = [
  {
    name                   = "cft-aks-00"
    address_prefix         = "10.101.128.0/19"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft-aks-01"
    address_prefix         = "10.101.160.0/19"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

coreinfra_subnets = [
  {
    name = "core-infra-subnet-0-preview"
  },
  {
    name = "core-infra-subnet-1-preview"
  },
  {
    name = "elasticsearch"
  },
  {
    name = "scan-storage"
  }
]
