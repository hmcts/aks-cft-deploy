enable_debug = "true"

network_address_space                  = "10.48.64.0/18"
aks_00_subnet_cidr_blocks              = "10.48.64.0/20"
aks_01_subnet_cidr_blocks              = "10.48.80.0/20"
iaas_subnet_cidr_blocks                = "10.48.97.0/24"
application_gateway_subnet_cidr_blocks = "10.48.96.0/25"
postgresql_subnet_cidr_blocks          = "10.48.104.0/25"
postgresql_subnet_expanded_cidr_blocks = "10.48.108.0/22"

additional_subnets = [
  {
    name           = "api-management"
    address_prefix = "10.48.96.128/25"
  },
  {
    name           = "private-endpoints"
    address_prefix = "10.48.100.0/22"
  },
  {
    name           = "infra-appgws"
    address_prefix = "10.48.98.0/25"
  }
]

private_dns_subscription = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_zones = [
  "perftest.platform.hmcts.net",
  "service.core-compute-perftest.internal",
  "service.core-compute-idam-perftest.internal"
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
    name                   = "core_infra_vnet_idam_perftest"
    address_prefix         = "10.120.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core_infra_subnet_mgmtperftest"
    address_prefix         = "10.112.160.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft-ptl-vnet"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core-infra-vnet-perftest"
    address_prefix         = "10.112.128.0/18"
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
    name                   = "ss-test-vnet"
    address_prefix         = "10.141.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "ss-test-vnet-snat"
    address_prefix         = "10.25.33.32/27"
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
    name                   = "aks-00"
    address_prefix         = "10.48.64.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "aks-01"
    address_prefix         = "10.48.80.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "soc_prod"
    address_prefix         = "10.146.0.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cftptl"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

coreinfra_subnets = [
  {
    name = "elasticsearch"
  },
  {
    name = "core-infra-subnet-1-perftest"
  },
  {
    name = "core-infra-subnet-apimgmt-perftest"
  },
  {
    name = "core-infra-subnet-2-perftest"
  }
]
