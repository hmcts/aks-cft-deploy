enable_debug = "true"

network_address_space                  = "10.70.24.0/21"
aks_00_subnet_cidr_blocks              = "10.70.24.0/23"
aks_01_subnet_cidr_blocks              = "10.70.26.0/23"
iaas_subnet_cidr_blocks                = "10.70.28.0/24"
application_gateway_subnet_cidr_blocks = "10.70.29.0/24"
postgresql_subnet_cidr_blocks          = "10.70.30.0/25"
postgresql_subnet_expanded_cidr_blocks = "10.70.31.128/25"

additional_subnets = [
  {
    name           = "private-endpoints"
    address_prefix = "10.70.30.128/25"
  }
]

private_dns_subscription = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
private_dns_zones = [
  "sandbox.platform.hmcts.net",
  "sbox.platform.hmcts.net",
  "service.core-compute-sandbox.internal",
  "service.core-compute-idam-sandbox.internal",
  "service.core-compute-idam-saat.internal",
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
    name                   = "dynatrace-nonprod-vnet"
    address_prefix         = "10.10.80.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  }
]

additional_routes_coreinfra = [
]
