cluster_count                      = 2
kubernetes_cluster_version         = "1.19.11"
kubernetes_cluster_agent_min_count = "30"
kubernetes_cluster_agent_max_count = "50"
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUDkk4BOuQmaj4kO5PEyZ1+HR8u2AzRNkmFkICcQWJakXpNvzec+u1s8nSRaWtuZ8ubQwkTluCHY/OxCdmMOxG3K1+t2Dm0edhPTjGwRuRHzFLawEl8OSvMG97hg3aQMtjlflm05Ao2UCNG1wJLJrkiB5RIu2mBvp1hXolQsbTNUhZLDFDLJYRVoF49EzLbxVwM2jSm1hZESeB+BFgcQJQuEe9ORSldSYqK/c3mw+7EqCw3+zFvkN9fS1z9x2Zg2cnnVCLi/HE6Ul/QDD4TBb/1dFXUEZakXId8oP+W8e/2lTbGbjfW4l3ZnFRyT9B1qO5pQZXAE/CapVOVNOzoG6F"
sku_tier                           = "Paid"
enable_user_system_nodepool_split  = true

system_node_pool = {
  min_nodes = 30,
  max_nodes = 50
}
linux_node_pool = {
  min_nodes = 4,
  max_nodes = 10
}

availability_zones = ["1"]

aks-cluster-nsg-rules = [
  {
    name                       = "AllowInternetToOAuthProxy"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80, 443"
    source_address_prefix      = "*"
    destination_address_prefix = "51.11.25.221, 20.68.184.102"
  },
  {
    name                       = "TraefikNoProxy"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "51.11.5.163, 20.68.186.154"
  },
  {
    name                       = "BulkscanToCrimeStorage"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "10.200.66.12"
  }
]