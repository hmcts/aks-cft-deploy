enable_debug = "true"

network_address_space                  = "10.48.64.0/18"
aks_00_subnet_cidr_blocks              = "10.48.64.0/20"
aks_01_subnet_cidr_blocks              = "10.48.80.0/20"
iaas_subnet_cidr_blocks                = "10.48.97.0/24"
application_gateway_subnet_cidr_blocks = "10.48.96.0/25"
postgresql_subnet_cidr_blocks          = "10.48.104.0/25"

additional_subnets = [
  {
    name           = "api-management"
    address_prefix = "10.48.96.128/25"
  },
  {
    name           = "private-endpoints"
    address_prefix = "10.48.100.0/22"
  },
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
    name                   = "10_0_0_0"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "172_16_0_0"
    address_prefix         = "172.16.0.0/12"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "192_168_0_0"
    address_prefix         = "192.168.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_appgw = [
  {
    name                   = "core_infra_vnet_idam_perftest"
    address_prefix         = "10.120.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core_infra_subnet_mgmtperftest"
    address_prefix         = "10.112.160.0/24"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft-ptl-vnet"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core-infra-vnet-perftest"
    address_prefix         = "10.112.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_coreinfra = [
  {
    name                   = "aks-00"
    address_prefix         = "10.48.64.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "aks-01"
    address_prefix         = "10.48.80.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "soc_prod"
    address_prefix         = "10.146.0.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

coreinfra_subnets = [
  {
    name = "elasticsearch"
  },
  {
    name = "core-infra-subnet-1-perftest"
  },
  {
    name = "core-infra-subnet-apimgmt-perftest"
  }
]


cluster_count                      = 2
kubernetes_cluster_version         = "1.23"
kubernetes_cluster_agent_min_count = "70"
kubernetes_cluster_agent_max_count = "100"
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2lguwg1h0qcaPqPZutQChBAtDK9USDTKNpnY3miVD0cwtFE/Q8U9A3KAfR0wI/WOystKXKGO8e3wq8xf6Pe08aCrbi7X8zIsixKgpQiNXT3j1zRz2Ae4Sa06znSiyzadCv4gSzWsq6m7Sq3FQJ7f2/USDemm1yA0Nena8g73IjxFe0zErqtnRhzicaccxDxaoZNBrfRotV+Nz6FEegUkVnqr+5Jy4H3XvdXfDPc1UzDAn0iBptEW80tcyKZsj7l2Cl20JjnSZ2PwGX/FMzzZIeTtR+eo7/3HxiaZumYAFLcfQ+ZCzId5hA6g30hsSi17HlMco//KkfgReaxXz+gDT aks-ssh"
enable_user_system_nodepool_split  = true
oms_agent_enabled                  = true
system_node_pool = {
  min_nodes = 2,
  max_nodes = 4
}
linux_node_pool = {
  min_nodes = 70,
  max_nodes = 100
}

availability_zones = ["1", "2", "3"]