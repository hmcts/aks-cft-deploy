cluster_count                      = 2
kubernetes_cluster_version         = "1.21.7"
kubernetes_cluster_agent_min_count = "40"
kubernetes_cluster_agent_max_count = "60"
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfTT+Bu3rkDptVCj03j8jyflM6bZxNp4tgi0GibRciAops5dOkbtoWKBNpHfGH5AlTKnReRJTlfqM88DjGnYZwYtfx7Kqf3rxNXfwFqXrVYETGy0SNo11WrBSNHDnyfNVm5UFE7HmpSoGVr+C9/OCVmzTDbYoPppGZ79Iv74CLMpsIM8XuD2lQAolODLfA55OTdeJJLgyFu0cEB3ZrrM2DXwMm5CI8C05ACDvDkEO4vtGK9OCYYkxT9/3pskk/ub+IpjuEajryK2fhsPDFwmTVzaMAvM9HIIvDyvfJXjGlGp12d/wubHQ3HlXgUxvU2UF+ggPaaSfQnqALtQ/PwcHf aks-ssh"
sku_tier                           = "Paid"
enable_user_system_nodepool_split  = true

system_node_pool = {
  min_nodes = 40,
  max_nodes = 60
}
linux_node_pool = {
  min_nodes = 4,
  max_nodes = 10
}

availability_zones = ["1", "2", "3"]