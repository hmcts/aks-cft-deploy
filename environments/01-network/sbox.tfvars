enable_debug = "true"

network_address_space                  = "10.2.8.0/21"
aks_00_subnet_cidr_blocks              = "10.2.8.0/23"
aks_01_subnet_cidr_blocks              = "10.2.10.0/23"
iaas_subnet_cidr_blocks                = "10.2.12.0/24"
application_gateway_subnet_cidr_blocks = "10.2.13.0/25"

additional_subnets = [
]

private_dns_subscription = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
private_dns_zones = [
  "sandbox.platform.hmcts.net",
  "sbox.platform.hmcts.net",
  "service.core-compute-sandbox.internal",
  "service.core-compute-idam-sandbox.internal",
  "service.core-compute-idam-sprod.internal",
  "service.core-compute-idam-saat.internal"
]

hub = "sbox"

additional_routes = [
]

additional_routes_appgw = [
  # {
  #   name                   = "core_infra_vnet_idam_sandbox"
  #   address_prefix         = "10.99.128.0/18"
  #   next_hop_type          = "VirtualAppliance"
  #   next_hop_in_ip_address = "10.10.200.36"
  # },
  # {
  #   name                   = "vpn"
  #   address_prefix         = "10.99.0.0/18"
  #   next_hop_type          = "VirtualAppliance"
  #   next_hop_in_ip_address = "10.10.200.36"
  # }
]