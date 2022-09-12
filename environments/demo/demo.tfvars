enable_debug = "true"

network_address_space                  = "10.50.64.0/18"
aks_00_subnet_cidr_blocks              = "10.50.64.0/20"
aks_01_subnet_cidr_blocks              = "10.50.80.0/20"
iaas_subnet_cidr_blocks                = "10.50.96.0/24"
application_gateway_subnet_cidr_blocks = "10.50.97.0/25"
postgresql_subnet_cidr_blocks          = "10.50.104.0/25"

additional_subnets = [
  {
    name           = "api-management"
    address_prefix = "10.50.97.128/25"
  },
  {
    name           = "private-endpoints"
    address_prefix = "10.50.100.0/22"
  },
]

private_dns_subscription = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
private_dns_zones = [
  "demo.platform.hmcts.net",
  "service.core-compute-demo.internal",
  "service.core-compute-idam-demo.internal",
  "test.platform.hmcts.net"
]

hub = "nonprod"

additional_routes = [
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
  },
  {
    name                   = "10_0_0_0"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_appgw = [
  {
    name                   = "cft-ptl-vnet"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core-infra-vnet-idam-demo"
    address_prefix         = "10.97.128.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "core-infra-vnet-demo"
    address_prefix         = "10.96.192.0/18"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  }
]

additional_routes_coreinfra = [
  {
    name                   = "nonprodHub"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
  {
    name                   = "ptl"
    address_prefix         = "10.10.72.0/21"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.72.36"
  },
]

coreinfra_subnets = [
  {
    name = "core-infra-subnet-apimgmt-demo"
  }
]


cluster_count                      = 2
kubernetes_cluster_version         = "1.21.7"
kubernetes_cluster_agent_min_count = "40"
kubernetes_cluster_agent_max_count = "50"
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUDkk4BOuQmaj4kO5PEyZ1+HR8u2AzRNkmFkICcQWJakXpNvzec+u1s8nSRaWtuZ8ubQwkTluCHY/OxCdmMOxG3K1+t2Dm0edhPTjGwRuRHzFLawEl8OSvMG97hg3aQMtjlflm05Ao2UCNG1wJLJrkiB5RIu2mBvp1hXolQsbTNUhZLDFDLJYRVoF49EzLbxVwM2jSm1hZESeB+BFgcQJQuEe9ORSldSYqK/c3mw+7EqCw3+zFvkN9fS1z9x2Zg2cnnVCLi/HE6Ul/QDD4TBb/1dFXUEZakXId8oP+W8e/2lTbGbjfW4l3ZnFRyT9B1qO5pQZXAE/CapVOVNOzoG6F"
enable_user_system_nodepool_split  = true

system_node_pool = {
  min_nodes = 4,
  max_nodes = 10
}
linux_node_pool = {
  min_nodes = 30,
  max_nodes = 50
}

availability_zones = ["1", "2", "3"]
