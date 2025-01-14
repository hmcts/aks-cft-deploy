enable_debug = "true"

network_address_space                  = "10.2.0.0/19"
aks_00_subnet_cidr_blocks              = "10.2.8.0/23"
aks_01_subnet_cidr_blocks              = "10.2.10.0/23"
iaas_subnet_cidr_blocks                = "10.2.12.0/25"
application_gateway_subnet_cidr_blocks = "10.2.13.0/25"
postgresql_subnet_cidr_blocks          = "10.2.14.128/25"
postgresql_subnet_expanded_cidr_blocks = "10.2.13.128/25"

additional_subnets = [
  {
    name           = "api-management"
    address_prefix = "10.2.14.0/25"
  },
  {
    name           = "private-endpoints"
    address_prefix = "10.2.15.0/24"
  },
  {
    name           = "infra-appgws"
    address_prefix = "10.2.12.128/25"
  }
]

private_dns_subscription = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
private_dns_zones = [
  "sandbox.platform.hmcts.net",
  "sbox.platform.hmcts.net",
  "service.core-compute-sandbox.internal",
  "service.core-compute-idam-sandbox.internal",
  "service.core-compute-idam-saat.internal"
]

hub = "sbox"

additional_routes = [
  {
    name                   = "10_0_0_0"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  },
  {
    name                   = "172_16_0_0"
    address_prefix         = "172.16.0.0/12"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  },
  {
    name                   = "192_168_0_0"
    address_prefix         = "192.168.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  }
]

additional_routes_application_gateway = [
  {
    name                   = "core_infra_vnet_idam_sandbox"
    address_prefix         = "10.99.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  },
  {
    name                   = "core-infra-vnet-sandbox"
    address_prefix         = "10.100.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  },
  {
    name                   = "cft-ptlsbox-vnet"
    address_prefix         = "10.70.24.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
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
    next_hop_in_ip_address = "10.10.200.36"
  }
]

additional_routes_coreinfra = [
  {
    name                   = "aks-00"
    address_prefix         = "10.2.8.0/23"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  },
  {
    name                   = "aks-01"
    address_prefix         = "10.2.10.0/23"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  }
]

coreinfra_subnets = [
  {
    name = "core-infra-subnet-0-sandbox"
  },
  {
    name = "core-infra-subnet-1-sandbox"
  },
  {
    name = "elasticsearch"
  },
  {
    name = "scan-storage"
  },
  {
    name = "core-infra-subnet-apimgmt-sandbox"
  }
]
