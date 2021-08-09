enable_debug = "true"

network_address_space                  = "10.10.128.0/18"
aks_00_subnet_cidr_blocks              = "10.10.128.0/20"
aks_01_subnet_cidr_blocks              = "10.10.144.0/20"
iaas_subnet_cidr_blocks                = "10.10.160.0/24"
application_gateway_subnet_cidr_blocks = "10.10.161.0/25"

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
    name                   = "preview"
    address_prefix         = "10.12.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "10_0_0_0"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "172_16_0_0"
    address_prefix         = "172.16.0.0/12"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "192_168_0_0"
    address_prefix         = "192.168.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  }
]

additional_routes_appgw = [
  {
    name                   = "core_infra_vnet_idam_ithc2"
    address_prefix         = "10.103.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "core_cftptl_intvsc_vnet"
    address_prefix         = "10.10.64.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "core_preview_vnet"
    address_prefix         = "10.12.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]