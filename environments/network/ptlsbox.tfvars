enable_debug = "true"

network_address_space                  = "10.70.24.0/21"
aks_00_subnet_cidr_blocks              = "10.70.24.0/23"
aks_01_subnet_cidr_blocks              = "10.70.40.0/23"
iaas_subnet_cidr_blocks                = "10.70.56.0/24"
application_gateway_subnet_cidr_blocks = "10.70.57.0/25"

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
