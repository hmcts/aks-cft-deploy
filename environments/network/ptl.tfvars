enable_debug = "true"

network_address_space                  = "10.10.72.0/21"
aks_00_subnet_cidr_blocks              = "10.10.72.0/23"
aks_01_subnet_cidr_blocks              = "10.10.74.0/23"
iaas_subnet_cidr_blocks                = "10.10.76.0/23"
application_gateway_subnet_cidr_blocks = "10.10.78.0/25"
postgresql_subnet_cidr_blocks          = "10.10.78.128/25"

additional_subnets = [
  {
    name           = "private-endpoints"
    address_prefix = "10.10.79.0/25"
  }
]

private_dns_subscription = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_zones = [
  "aat.platform.hmcts.net",
  "demo.platform.hmcts.net",
  "dev.platform.hmcts.net",
  "dom1.infra.int",
  "ethosldata.platform.hmcts.net",
  "ithc.platform.hmcts.net",
  "mailrelay.internal.platform.hmcts.net",
  "mailrelay.platform.hmcts.net",
  "perftest.platform.hmcts.net",
  "preview.platform.hmcts.net",
  "privatelink.dev.azuresynapse.net",
  "privatelink.sql.azuresynapse.net",
  "prod.platform.hmcts.net",
  "service.core-compute-aat.internal",
  "service.core-compute-demo.internal",
  "service.core-compute-ethosldata.internal",
  "service.core-compute-idam-aat.internal",
  "service.core-compute-idam-aat2.internal",
  "service.core-compute-idam-demo.internal",
  "service.core-compute-idam-ethosldata.internal",
  "service.core-compute-idam-ithc.internal",
  "service.core-compute-idam-perftest.internal",
  "service.core-compute-idam-preview.internal",
  "service.core-compute-idam-prod.internal",
  "service.core-compute-idam-prod2.internal",
  "service.core-compute-ithc.internal",
  "service.core-compute-perftest.internal",
  "service.core-compute-preview.internal",
  "service.core-compute-prod.internal",
  "staging.platform.hmcts.net",
  "test.platform.hmcts.net",
]

hub = "prod"

additional_routes = [
  {
    name                   = "sdsdev"
    address_prefix         = "10.145.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "sdsptl"
    address_prefix         = "10.147.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "dmz-ukw"
    address_prefix         = "10.49.69.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.49.72.36"
  },
  {
    name                   = "cftperftest"
    address_prefix         = "10.48.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cftithc"
    address_prefix         = "10.11.192.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cftpreview"
    address_prefix         = "10.48.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cftdemo"
    address_prefix         = "10.50.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "test"
    address_prefix         = "10.25.240.0/21"
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
  },
  {
    name                   = "npcol-stg-subnet1"
    address_prefix         = "10.25.248.0/23"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "npcol-stg-subnet2"
    address_prefix         = "10.225.248.0/23"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cftperftest-coreinfra"
    address_prefix         = "10.112.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cftithc-coreinfra"
    address_prefix         = "10.112.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cftdemo-coreinfra"
    address_prefix         = "10.96.192.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "sdsithc"
    address_prefix         = "10.143.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "sdstest"
    address_prefix         = "10.141.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "mgmt-nonprod"
    address_prefix         = "10.48.0.32/27"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "jump-box-prod"
    address_prefix         = "10.24.250.0/26"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "jump-box-nonprod"
    address_prefix         = "10.25.250.0/26"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "mi-vnet-dev"
    address_prefix         = "10.168.1.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_coreinfra = [
]
