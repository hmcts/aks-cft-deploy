cluster_count                     = 2
kubernetes_cluster_version        = "1.30"
kubernetes_cluster_ssh_key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUDkk4BOuQmaj4kO5PEyZ1+HR8u2AzRNkmFkICcQWJakXpNvzec+u1s8nSRaWtuZ8ubQwkTluCHY/OxCdmMOxG3K1+t2Dm0edhPTjGwRuRHzFLawEl8OSvMG97hg3aQMtjlflm05Ao2UCNG1wJLJrkiB5RIu2mBvp1hXolQsbTNUhZLDFDLJYRVoF49EzLbxVwM2jSm1hZESeB+BFgcQJQuEe9ORSldSYqK/c3mw+7EqCw3+zFvkN9fS1z9x2Zg2cnnVCLi/HE6Ul/QDD4TBb/1dFXUEZakXId8oP+W8e/2lTbGbjfW4l3ZnFRyT9B1qO5pQZXAE/CapVOVNOzoG6F"
enable_user_system_nodepool_split = true
workload_identity_enabled         = true
service_operator_settings_enabled = true

system_node_pool = {
  vm_size   = "Standard_D4ds_v5",
  min_nodes = 4,
  max_nodes = 10
}
linux_node_pool = {
  vm_size   = "Standard_D8ds_v5",
  min_nodes = 20,
  max_nodes = 30,
  max_pods  = 50
}

availability_zones = ["1", "2", "3"]
csi_driver_enabled = true
