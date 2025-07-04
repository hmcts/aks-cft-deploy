clusters = {
  "00" = {
    kubernetes_cluster_version        = "1.32"
    kubernetes_cluster_ssh_key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWNmn9m1WkjbXlAWPBeboOjBP9SLc8E6Fsqytdr7pZ3xZ9IwJnzUjYADNuYejCJ0v8KaTF+5THOS0JUIcfmUncE5Kj08o4e/zLxFyNNNfoSePldTMgbbBMd5jTjKB8rBrPif2Oj4e0PjcgEXBVaUvwgoVrh/nkhhzfoydV/DmZ/vpKmJiPrH1plWm8pQheM2g3TrhfIsUXityvPbDBhdCShyLX6I4u10VjZJTXw1DVDVdVYxPKEPUyrYu+qLJGR7M48p0T39nq6bAlxmyQoBdDxgDbZDmfjq2Qyk68xldIlsj/WTXASbY70aO3sV47Qlf7cUEw8ghCWyDCf9Ji2Nbx aks-ssh"
    enable_user_system_nodepool_split = true

    system_node_pool = {
      vm_size   = "Standard_D4ds_v5"
      min_nodes = 2
      max_nodes = 4
    }

    linux_node_pool = {
      vm_size   = "Standard_D8ds_v5"
      min_nodes = 5
      max_nodes = 10
    }

    node_os_maintenance_window_config = {
      frequency  = "Daily"
      start_time = "16:00"
      is_prod    = false
    }

    availability_zones = []
  }
}
autoShutdown = true

#   "01" = {
#     kubernetes_cluster_version        = "1.30"
#     kubernetes_cluster_ssh_key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDWNmn9m1WkjbXlAWPBeboOjBP9SLc8E6Fsqytdr7pZ3xZ9IwJnzUjYADNuYejCJ0v8KaTF+5THOS0JUIcfmUncE5Kj08o4e/zLxFyNNNfoSePldTMgbbBMd5jTjKB8rBrPif2Oj4e0PjcgEXBVaUvwgoVrh/nkhhzfoydV/DmZ/vpKmJiPrH1plWm8pQheM2g3TrhfIsUXityvPbDBhdCShyLX6I4u10VjZJTXw1DVDVdVYxPKEPUyrYu+qLJGR7M48p0T39nq6bAlxmyQoBdDxgDbZDmfjq2Qyk68xldIlsj/WTXASbY70aO3sV47Qlf7cUEw8ghCWyDCf9Ji2Nbx aks-ssh"
#     ptl_cluster                       = true
#     enable_user_system_nodepool_split = true

#     system_node_pool = {
#       vm_size   = "Standard_D4ds_v5"
#       min_nodes = 2
#       max_nodes = 4
#     }

#     linux_node_pool = {
#       vm_size   = "Standard_D8ds_v5"
#       min_nodes = 5
#       max_nodes = 10
#     }

#     node_os_maintenance_window_config = {
#       frequency  = "Daily"
#       start_time = "16:00"
#       is_prod    = false
#     }

#     availability_zones = []
#   }
# }