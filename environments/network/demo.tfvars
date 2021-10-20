enable_debug = "true"
# TODO
network_address_space                  = "10.2.8.0/21"
aks_00_subnet_cidr_blocks              = "10.2.8.0/23"
aks_01_subnet_cidr_blocks              = "10.2.10.0/23"
iaas_subnet_cidr_blocks                = "10.2.12.0/24"
application_gateway_subnet_cidr_blocks = "10.2.13.0/25"

additional_subnets = [
]

private_dns_subscription = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_zones = [
  "demo.platform.hmcts.net",
  "service.core-compute-sandbox.internal",
  "service.core-compute-demo.internal",
  "service.core-compute-idam-demo.internal"
]

hub = "nonprod"

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
  },
  {
    name                   = "postgres"
    address_prefix         = "10.96.192.0/22"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "BastionMgmtVnet"
    address_prefix         = "10.48.0.32/27"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]
additional_routes_appgw = [
]

additional_routes_coreinfra = [
]

coreinfra_subnets = [
]