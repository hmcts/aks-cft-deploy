clusters = {
  "00" = {
    kubernetes_cluster_version        = "1.32"
    kubernetes_cluster_ssh_key        = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2lguwg1h0qcaPqPZutQChBAtDK9USDTKNpnY3miVD0cwtFE/Q8U9A3KAfR0wI/WOystKXKGO8e3wq8xf6Pe08aCrbi7X8zIsixKgpQiNXT3j1zRz2Ae4Sa06znSiyzadCv4gSzWsq6m7Sq3FQJ7f2/USDemm1yA0Nena8g73IjxFe0zErqtnRhzicaccxDxaoZNBrfRotV+Nz6FEegUkVnqr+5Jy4H3XvdXfDPc1UzDAn0iBptEW80tcyKZsj7l2Cl20JjnSZ2PwGX/FMzzZIeTtR+eo7/3HxiaZumYAFLcfQ+ZCzId5hA6g30hsSi17HlMco//KkfgReaxXz+gDT aks-ssh"
    enable_user_system_nodepool_split = true

    enable_automatic_channel_upgrade_patch = true
    system_node_pool = {
      vm_size   = "Standard_D4ds_v5"
      min_nodes = 4
      max_nodes = 6
    }
    linux_node_pool = {
      vm_size   = "Standard_D8ds_v5"
      min_nodes = 30
      max_nodes = 100
    }
    availability_zones = ["1", "2", "3"]

    node_os_maintenance_window_config = {
      frequency  = "Daily"
      start_time = "16:00"
      is_prod    = false
    }
  },
  "01" = {
    kubernetes_cluster_version = "1.32"
    kubernetes_cluster_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2lguwg1h0qcaPqPZutQChBAtDK9USDTKNpnY3miVD0cwtFE/Q8U9A3KAfR0wI/WOystKXKGO8e3wq8xf6Pe08aCrbi7X8zIsixKgpQiNXT3j1zRz2Ae4Sa06znSiyzadCv4gSzWsq6m7Sq3FQJ7f2/USDemm1yA0Nena8g73IjxFe0zErqtnRhzicaccxDxaoZNBrfRotV+Nz6FEegUkVnqr+5Jy4H3XvdXfDPc1UzDAn0iBptEW80tcyKZsj7l2Cl20JjnSZ2PwGX/FMzzZIeTtR+eo7/3HxiaZumYAFLcfQ+ZCzId5hA6g30hsSi17HlMco//KkfgReaxXz+gDT aks-ssh"

    enable_user_system_nodepool_split = true

    enable_automatic_channel_upgrade_patch = true
    system_node_pool = {
      vm_size   = "Standard_D4ds_v5"
      min_nodes = 4
      max_nodes = 6
    }

    linux_node_pool = {
      vm_size   = "Standard_D8ds_v5"
      min_nodes = 30
      max_nodes = 100
    }

    availability_zones = ["1", "2", "3"]

    node_os_maintenance_window_config = {
      frequency  = "Daily"
      start_time = "16:00"
      is_prod    = false
    }
  }
}
oms_agent_enabled = true
autoShutdown      = true