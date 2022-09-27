enable_debug = "true"

################################################################################
# Network configuration
################################################################################

network_address_space                  = "10.70.24.0/21"
aks_00_subnet_cidr_blocks              = "10.70.24.0/23"
aks_01_subnet_cidr_blocks              = "10.70.26.0/23"
iaas_subnet_cidr_blocks                = "10.70.28.0/24"
application_gateway_subnet_cidr_blocks = "10.70.29.0/24"
postgresql_subnet_cidr_blocks          = "10.70.30.0/25"

additional_subnets = [
]

private_dns_subscription = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
private_dns_zones = [
  "sandbox.platform.hmcts.net",
  "sbox.platform.hmcts.net",
  "service.core-compute-sandbox.internal",
  "service.core-compute-idam-sandbox.internal",
  "service.core-compute-idam-saat.internal",
]

hub = "sbox"

additional_routes = [
  {
    name                   = "10_0_0_0"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  },
  {
    name                   = "172_16_0_0"
    address_prefix         = "172.16.0.0/12"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  },
  {
    name                   = "192_168_0_0"
    address_prefix         = "192.168.0.0/16"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.10.200.36"
  }
]

additional_routes_coreinfra = [
]

################################################################################
# Kubernetes configuration
################################################################################

cluster_count                      = 1
kubernetes_cluster_version         = "1.23"
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWNmn9m1WkjbXlAWPBeboOjBP9SLc8E6Fsqytdr7pZ3xZ9IwJnzUjYADNuYejCJ0v8KaTF+5THOS0JUIcfmUncE5Kj08o4e/zLxFyNNNfoSePldTMgbbBMd5jTjKB8rBrPif2Oj4e0PjcgEXBVaUvwgoVrh/nkhhzfoydV/DmZ/vpKmJiPrH1plWm8pQheM2g3TrhfIsUXityvPbDBhdCShyLX6I4u10VjZJTXw1DVDVdVYxPKEPUyrYu+qLJGR7M48p0T39nq6bAlxmyQoBdDxgDbZDmfjq2Qyk68xldIlsj/WTXASbY70aO3sV47Qlf7cUEw8ghCWyDCf9Ji2Nbx aks-ssh"
ptl_cluster                        = true
enable_user_system_nodepool_split  = true

system_node_pool = {
  min_nodes = 2,
  max_nodes = 4
}
linux_node_pool = {
  min_nodes = 8,
  max_nodes = 10
}

availability_zones = []
