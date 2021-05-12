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
]

hub = "sbox"

additional_routes = [
]