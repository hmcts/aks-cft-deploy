enable_debug = "true"

network_address_space                  = "10.10.128.0/18"
aks_00_subnet_cidr_blocks              = "10.10.208.0/20"
aks_01_subnet_cidr_blocks              = "10.10.224.0/20"
iaas_subnet_cidr_blocks                = "10.10.252.0/24"
application_gateway_subnet_cidr_blocks = "10.15.1.0/24"

additional_subnets = [
]

private_dns_subscription = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
private_dns_zones = [
  "perftest.platform.hmcts.net",
  "service.core-compute-perftest.internal",
  "service.core-compute-idam-perftest.internal",
  "service.core-compute-perftest.internal",
  "service.core-compute-idam-perftest.internal",
  "service.core-compute-idam-sprod.internal",
  "service.core-compute-idam-saat.internal"
]

hub = "sbox"

additional_routes = [
  {
    name                   = "core_infra_vnet_idam_sandbox"
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