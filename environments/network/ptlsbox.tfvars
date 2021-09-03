enable_debug = "true"

network_address_space                  = "10.50.64.0/18"
aks_00_subnet_cidr_blocks              = "10.50.64.0/20"
aks_01_subnet_cidr_blocks              = "10.50.80.0/20"
iaas_subnet_cidr_blocks                = "10.50.96.0/24"
application_gateway_subnet_cidr_blocks = "10.50.97.0/25"

additional_subnets = [
]

private_dns_subscription = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
private_dns_zones = [
  "sbox.platform.hmcts.net",
  "service.core-compute-sandbox.internal",
  "service.core-compute-idam-sandbox.internal",
  "service.core-compute-idam-sprod.internal",
  "service.core-compute-idam-saat.internal",
]

hub = "sbox"

additional_routes = [
  {
    name                   = "BastionMgmtVnet"
    address_prefix         = "10.48.0.96/27"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  },
  {
    name                   = "internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  }
]

additional_routes_appgw = [ # TODO
  {
    name                   = "core_infra_vnet_idam_ithc"
    address_prefix         = "10.120.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core_infra_subnet_mgmtithc"
    address_prefix         = "10.112.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core_cftptl_intvsc_vnet"
    address_prefix         = "10.10.64.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_coreinfra = [ # TODO
  {
    name                   = "aks-00"
    address_prefix         = "10.11.192.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "aks-01"
    address_prefix         = "10.11.208.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

coreinfra_subnets = [ # TODO
  {
    name = "core-infra-subnet-0-ithc"
  },
  {
    name = "core-infra-subnet-1-ithc"
  },
  {
    name = "elasticsearch"
  },
  {
    name = "scan-storage"
  }
]