enable_debug = "true"

network_address_space                  = "10.101.128.0/17"
aks_00_subnet_cidr_blocks              = "10.101.128.0/19"
aks_01_subnet_cidr_blocks              = "10.101.160.0/19"
iaas_subnet_cidr_blocks                = "10.101.192.0/24"
application_gateway_subnet_cidr_blocks = "10.101.193.0/25"
postgresql_subnet_cidr_blocks          = "10.101.200.0/25"

additional_subnets = [
  {
    name           = "api-management"
    address_prefix = "10.101.193.128/25"
  },
  {
    name           = "private-endpoints"
    address_prefix = "10.101.196.0/22"
  },
]

private_dns_subscription = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_zones = [
  "preview.platform.hmcts.net",
  "service.core-compute-preview.internal",
  "service.core-compute-idam-preview.internal",
  "aat.platform.hmcts.net",
  "service.core-compute-aat.internal",
  "service.core-compute-idam-aat.internal",
  "service.core-compute-idam-aat2.internal"
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
    name                   = "core_infra_vnet_idam_preview"
    address_prefix         = "10.97.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core_infra_subnet_mgmtpreview"
    address_prefix         = "10.97.0.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft-ptl-vnet"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_coreinfra = [
  {
    name                   = "cft-aks-00"
    address_prefix         = "10.101.128.0/19"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "cft-aks-01"
    address_prefix         = "10.101.160.0/19"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

coreinfra_subnets = [
  {
    name = "core-infra-subnet-0-preview"
  },
  {
    name = "core-infra-subnet-1-preview"
  },
  {
    name = "elasticsearch"
  },
  {
    name = "scan-storage"
  }
]


cluster_count                      = 2
kubernetes_cluster_version         = "1.23"
kubernetes_cluster_agent_min_count = "30"
kubernetes_cluster_agent_max_count = "140"
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+s99FmkHwqdBbbzgw0Q9vqqJb0VkJ+QrmN5elArYOSX5HER+jAooyOEiZNynoL+oYBZT52p6sSVOvvccl06GX1FNfRkC6A8DlAUeIPO56N4/8awfxT1F1ydjMWHgZcZrPZiFUxH/duvlGqtqnO0iQzWKLsXovGFn0xPRAexK0004Ij1igfMZ+PyxQBunawZFo67cSJu3LpHd/fxqGd/qHBQ1iR01NdRjEBIUKh3/0LxIhOB3I0jxadXGQYXwCV1xefhVrHS13dqJH9tNkHB8YbCQ24hiVd2bmxjBPhS767pfByLkzRIFkYX9l5aSIDl3QLOAQruv5F36kMN9OmyXz aks-ssh"
enable_user_system_nodepool_split  = true

system_node_pool = {
  min_nodes = 2,
  max_nodes = 4
}
linux_node_pool = {
  min_nodes = 30,
  max_nodes = 180
}

availability_zones = ["1", "2", "3"]
