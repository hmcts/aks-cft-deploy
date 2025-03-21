enable_debug = "true"

network_address_space                  = "10.50.64.0/18"
aks_00_subnet_cidr_blocks              = "10.50.64.0/20"
aks_01_subnet_cidr_blocks              = "10.50.80.0/20"
iaas_subnet_cidr_blocks                = "10.50.96.0/24"
application_gateway_subnet_cidr_blocks = "10.50.97.0/25"
postgresql_subnet_cidr_blocks          = "10.50.104.0/25"
postgresql_subnet_expanded_cidr_blocks = "10.50.106.0/23"

additional_subnets = [
  {
    name           = "api-management"
    address_prefix = "10.50.97.128/25"
  },
  {
    name           = "private-endpoints"
    address_prefix = "10.50.100.0/22"
  },
  {
    name           = "infra-appgws"
    address_prefix = "10.50.98.0/25"
  }
]

private_dns_subscription = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_zones = [
  "demo.platform.hmcts.net",
  "service.core-compute-demo.internal",
  "service.core-compute-idam-demo.internal",
  "test.platform.hmcts.net"
]

hub = "nonprod"

additional_routes = [
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
  },
  {
    name                   = "10_0_0_0"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_application_gateway = [
  {
    name                   = "cft-ptl-vnet"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core-infra-vnet-idam-demo"
    address_prefix         = "10.97.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core-infra-vnet-demo"
    address_prefix         = "10.96.192.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "pet_stg_network"
    address_prefix         = "192.170.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core_cftptl_intvsc_vnet"
    address_prefix         = "10.10.64.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "dynatrace-nonprod-vnet"
    address_prefix         = "10.10.80.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_coreinfra = [
  {
    name                   = "nonprodHub"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "ptl"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
]

coreinfra_subnets = [
  {
    name = "core-infra-subnet-apimgmt-demo"
  }
]
