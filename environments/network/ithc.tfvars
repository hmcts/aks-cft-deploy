enable_debug = "true"

network_address_space                  = "10.11.192.0/18"
aks_00_subnet_cidr_blocks              = "10.11.128.0/20"
aks_01_subnet_cidr_blocks              = "10.11.144.0/20"
iaas_subnet_cidr_blocks                = "10.11.160.0/24"
application_gateway_subnet_cidr_blocks = "10.11.161.0/25"

additional_subnets = [
]

private_dns_subscription = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_zones = [
  "ithc.platform.hmcts.net",
  "service.core-compute-ithc.internal",
  "service.core-compute-idam-ithc.internal",
]

hub = "prod"

additional_routes = [
  {
    name                   = "AKSITHCtoHUBPalo"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "BastionMgmtVnet"
    address_prefix         = "10.48.0.0/27"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "Internet"
    address_prefix         = "0.0.0.0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_appgw = [
  {
    name                   = "AKSITHCtoHUBPalo"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "BastionMgmtVnet"
    address_prefix         = "10.48.0.0/27"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "Internet"
    address_prefix         = "0.0.0.0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]