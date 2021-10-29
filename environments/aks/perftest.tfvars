cluster_count                      = 2
kubernetes_cluster_version         = "1.19.11"
kubernetes_cluster_agent_min_count = "55"
kubernetes_cluster_agent_max_count = "60"
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2lguwg1h0qcaPqPZutQChBAtDK9USDTKNpnY3miVD0cwtFE/Q8U9A3KAfR0wI/WOystKXKGO8e3wq8xf6Pe08aCrbi7X8zIsixKgpQiNXT3j1zRz2Ae4Sa06znSiyzadCv4gSzWsq6m7Sq3FQJ7f2/USDemm1yA0Nena8g73IjxFe0zErqtnRhzicaccxDxaoZNBrfRotV+Nz6FEegUkVnqr+5Jy4H3XvdXfDPc1UzDAn0iBptEW80tcyKZsj7l2Cl20JjnSZ2PwGX/FMzzZIeTtR+eo7/3HxiaZumYAFLcfQ+ZCzId5hA6g30hsSi17HlMco//KkfgReaxXz+gDT aks-ssh"

system_node_pool = {
  min_nodes = 55,
  max_nodes = 60
}