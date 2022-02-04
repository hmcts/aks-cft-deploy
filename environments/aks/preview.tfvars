cluster_count                      = 2
kubernetes_cluster_version         = "1.19.11"
kubernetes_cluster_agent_min_count = "30"
kubernetes_cluster_agent_max_count = "100"
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+s99FmkHwqdBbbzgw0Q9vqqJb0VkJ+QrmN5elArYOSX5HER+jAooyOEiZNynoL+oYBZT52p6sSVOvvccl06GX1FNfRkC6A8DlAUeIPO56N4/8awfxT1F1ydjMWHgZcZrPZiFUxH/duvlGqtqnO0iQzWKLsXovGFn0xPRAexK0004Ij1igfMZ+PyxQBunawZFo67cSJu3LpHd/fxqGd/qHBQ1iR01NdRjEBIUKh3/0LxIhOB3I0jxadXGQYXwCV1xefhVrHS13dqJH9tNkHB8YbCQ24hiVd2bmxjBPhS767pfByLkzRIFkYX9l5aSIDl3QLOAQruv5F36kMN9OmyXz aks-ssh"
enable_user_system_nodepool_split  = true

system_node_pool = {
  min_nodes = 2,
  max_nodes = 4
}
linux_node_pool = {
  min_nodes = 30,
  max_nodes = 100
}

availability_zones = ["1", "2", "3"]
