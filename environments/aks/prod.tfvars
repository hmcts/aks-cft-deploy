clusters = {
  "00" = {
    kubernetes_cluster_version = "1.32"
    kubernetes_cluster_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJveNt+D21qfusPdhstV5yLtCK8Wr0eg86iqM9b71ud/U/wb6dO6Pnmw4JiC7EXps17O1TCpfLLOe+rwgLE4LCNVGTqq38HNdiy7VACkNo7xjUmV56URBOds2cCjMiBLfr8iNIa5zrHdtdvImESSH4P13KplyBjlTiHOHnKOQWMgIBD2enbslsJbOcn5p0wxL3QW8z1NNPqZOrEFtkzm8nSrVio2yQo6JXOdb25cy1ecXoJMbXcvkJhxGqKP8mcTbqIkiSKEaamE5hnQFpzUbsmgnZVTINnft3Bu/9iQ8gcSS/sQ4VUy61kU0qIH2FITLntU0Nil0nHCaM3W+Mzmqv aks-ssh"

    enable_user_system_nodepool_split = true

    system_node_pool = {
      vm_size   = "Standard_D4ds_v5"
      min_nodes = 4
      max_nodes = 10
    }

    linux_node_pool = {
      vm_size   = "Standard_D8ds_v5"
      min_nodes = 30
      max_nodes = 100
    }
    availability_zones = ["1", "2", "3"]

    node_os_maintenance_window_config = {
      frequency  = "Daily"
      start_time = "23:00"
      is_prod    = true
    }
  },

  "01" = {
    kubernetes_cluster_version = "1.32"
    kubernetes_cluster_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJveNt+D21qfusPdhstV5yLtCK8Wr0eg86iqM9b71ud/U/wb6dO6Pnmw4JiC7EXps17O1TCpfLLOe+rwgLE4LCNVGTqq38HNdiy7VACkNo7xjUmV56URBOds2cCjMiBLfr8iNIa5zrHdtdvImESSH4P13KplyBjlTiHOHnKOQWMgIBD2enbslsJbOcn5p0wxL3QW8z1NNPqZOrEFtkzm8nSrVio2yQo6JXOdb25cy1ecXoJMbXcvkJhxGqKP8mcTbqIkiSKEaamE5hnQFpzUbsmgnZVTINnft3Bu/9iQ8gcSS/sQ4VUy61kU0qIH2FITLntU0Nil0nHCaM3W+Mzmqv aks-ssh"

    enable_user_system_nodepool_split = true

    system_node_pool = {
      vm_size   = "Standard_D4ds_v5"
      min_nodes = 4
      max_nodes = 10
    }

    linux_node_pool = {
      vm_size   = "Standard_D8ds_v5"
      min_nodes = 30
      max_nodes = 100
    }

    availability_zones = ["1", "2", "3"]

    node_os_maintenance_window_config = {
      frequency  = "Daily"
      start_time = "23:00"
      is_prod    = true
    }
  }
}
oms_agent_enabled                  = true
monitor_diagnostic_setting         = true
monitor_diagnostic_setting_metrics = true
kube_audit_admin_logs_enabled      = true