clusters = {
  "00" = {
    kubernetes_cluster_version        = "1.30"
    enable_user_system_nodepool_split = true
    project_acr_enabled               = true

    enable_automatic_channel_upgrade_patch = true

    system_node_pool = {
      vm_size   = "Standard_D4ds_v5",
      min_nodes = 2
      max_nodes = 4
    }

    linux_node_pool = {
      vm_size   = "Standard_D4ds_v5",
      min_nodes = 4
      max_nodes = 10
      max_pods  = 30
    }

    spot_node_pool = {
      vm_size   = "Standard_D4ds_v5",
      min_nodes = 1
      max_nodes = 5
      max_pods  = 30
    }

    availability_zones = ["1"]
    autoShutdown       = true

    node_os_maintenance_window_config = {
      frequency  = "Daily"
      start_time = "16:00"
      is_prod    = false
    }
  },

  "01" = {
    kubernetes_cluster_version        = "1.30"
    enable_user_system_nodepool_split = true
    project_acr_enabled               = true

    enable_automatic_channel_upgrade_patch = true

    system_node_pool = {
      vm_size   = "Standard_D4ds_v5"
      min_nodes = 2
      max_nodes = 4
    }

    linux_node_pool = {
      vm_size   = "Standard_D4ds_v5"
      min_nodes = 4
      max_nodes = 10
      max_pods  = 30
    }

    spot_node_pool = {
      vm_size   = "Standard_D4ds_v5"  # Ensure vm_size is provided
      min_nodes = 1
      max_nodes = 5
      max_pods  = 30
    }

    availability_zones = ["1"]
    autoShutdown       = true

    node_os_maintenance_window_config = {
      frequency  = "Daily"
      start_time = "16:00"
      is_prod    = false
    }
  }
}