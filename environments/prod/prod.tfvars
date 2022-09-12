enable_debug = "true"

network_address_space                  = "10.90.64.0/18"
aks_00_subnet_cidr_blocks              = "10.90.64.0/20"
aks_01_subnet_cidr_blocks              = "10.90.80.0/20"
iaas_subnet_cidr_blocks                = "10.90.97.0/24"
application_gateway_subnet_cidr_blocks = "10.90.96.0/25"
postgresql_subnet_cidr_blocks          = "10.90.104.0/25"

additional_subnets = [
  {
    name           = "api-management"
    address_prefix = "10.90.96.128/25"
  },
  {
    name           = "private-endpoints"
    address_prefix = "10.90.100.0/22"
  },
]

private_dns_subscription = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_zones = [
  "service.core-compute-prod.internal",
  "service.core-compute-idam-prod.internal",
  "service.core-compute-idam-prod2.internal"
]

hub = "prod"

additional_routes = [
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
    name                   = "core_cftptl_intvsc_vnet"
    address_prefix         = "10.10.64.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "core-idam-prod2-vnet"
    address_prefix         = "10.106.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "core-infra-vnet-prod"
    address_prefix         = "10.96.64.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  }
]

additional_routes_coreinfra = [
  {
    name                   = "aks-00"
    address_prefix         = "10.90.64.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "aks-01"
    address_prefix         = "10.90.80.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "ptl"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  },
  {
    name                   = "soc_prod"
    address_prefix         = "10.146.0.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  }
]

coreinfra_subnets = [
  {
    name = "elasticsearch"
  },
  {
    name = "core-infra-subnet-0-prod"
  },
  {
    name = "core-infra-subnet-1-prod"
  },
  {
    name = "scan-storage"
  },
  {
    name = "core-infra-subnet-apimgmt-prod"
  }
]


cluster_count                      = 2
kubernetes_cluster_version         = "1.21.7"
kubernetes_cluster_agent_min_count = "50"
kubernetes_cluster_agent_max_count = "60"
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJveNt+D21qfusPdhstV5yLtCK8Wr0eg86iqM9b71ud/U/wb6dO6Pnmw4JiC7EXps17O1TCpfLLOe+rwgLE4LCNVGTqq38HNdiy7VACkNo7xjUmV56URBOds2cCjMiBLfr8iNIa5zrHdtdvImESSH4P13KplyBjlTiHOHnKOQWMgIBD2enbslsJbOcn5p0wxL3QW8z1NNPqZOrEFtkzm8nSrVio2yQo6JXOdb25cy1ecXoJMbXcvkJhxGqKP8mcTbqIkiSKEaamE5hnQFpzUbsmgnZVTINnft3Bu/9iQ8gcSS/sQ4VUy61kU0qIH2FITLntU0Nil0nHCaM3W+Mzmqv aks-ssh"
enable_user_system_nodepool_split  = true
oms_agent_enabled                  = true
system_node_pool = {
  min_nodes = 4,
  max_nodes = 10
}
linux_node_pool = {
  min_nodes = 50,
  max_nodes = 60
}

availability_zones = []