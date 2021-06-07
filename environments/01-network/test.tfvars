enable_debug = "true"

network_address_space                  = "10.48.64.0/18"
aks_00_subnet_cidr_blocks              = "10.48.64.0/20"
aks_01_subnet_cidr_blocks              = "10.48.80.0/20"
iaas_subnet_cidr_blocks                = "10.48.97.0/24"
application_gateway_subnet_cidr_blocks = "10.48.96.0/25"

additional_subnets = [
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
    name                   = "core_infra_vnet_idam_perftest"
    address_prefix         = "10.120.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "vpn"
    address_prefix         = "10.99.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]