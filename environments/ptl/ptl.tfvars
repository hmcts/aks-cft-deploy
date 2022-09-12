enable_debug = "true"

network_address_space                  = "10.10.72.0/21"
aks_00_subnet_cidr_blocks              = "10.10.72.0/23"
aks_01_subnet_cidr_blocks              = "10.10.74.0/23"
iaas_subnet_cidr_blocks                = "10.10.76.0/23"
application_gateway_subnet_cidr_blocks = "10.10.78.0/25"
postgresql_subnet_cidr_blocks          = "10.10.78.128/25"

additional_subnets = [
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
  }
]

additional_routes_coreinfra = [
]


cluster_count                      = 1
kubernetes_cluster_version         = "1.21.7"
kubernetes_cluster_agent_min_count = "8"
kubernetes_cluster_agent_max_count = "10"
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWNmn9m1WkjbXlAWPBeboOjBP9SLc8E6Fsqytdr7pZ3xZ9IwJnzUjYADNuYejCJ0v8KaTF+5THOS0JUIcfmUncE5Kj08o4e/zLxFyNNNfoSePldTMgbbBMd5jTjKB8rBrPif2Oj4e0PjcgEXBVaUvwgoVrh/nkhhzfoydV/DmZ/vpKmJiPrH1plWm8pQheM2g3TrhfIsUXityvPbDBhdCShyLX6I4u10VjZJTXw1DVDVdVYxPKEPUyrYu+qLJGR7M48p0T39nq6bAlxmyQoBdDxgDbZDmfjq2Qyk68xldIlsj/WTXASbY70aO3sV47Qlf7cUEw8ghCWyDCf9Ji2Nbx aks-ssh"
ptl_cluster                        = true
enable_user_system_nodepool_split  = true

kubernetes_cluster_agent_vm_size = "Standard_DS4_v2"

system_node_pool = {
  min_nodes = 2,
  max_nodes = 4
}
linux_node_pool = {
  vm_size   = "Standard_DS4_v2",
  min_nodes = 8,
  max_nodes = 10
}

availability_zones = []