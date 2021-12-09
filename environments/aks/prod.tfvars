cluster_count                      = 2
kubernetes_cluster_version         = "1.19.11"
kubernetes_cluster_agent_min_count = "50"
kubernetes_cluster_agent_max_count = "60" 
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJveNt+D21qfusPdhstV5yLtCK8Wr0eg86iqM9b71ud/U/wb6dO6Pnmw4JiC7EXps17O1TCpfLLOe+rwgLE4LCNVGTqq38HNdiy7VACkNo7xjUmV56URBOds2cCjMiBLfr8iNIa5zrHdtdvImESSH4P13KplyBjlTiHOHnKOQWMgIBD2enbslsJbOcn5p0wxL3QW8z1NNPqZOrEFtkzm8nSrVio2yQo6JXOdb25cy1ecXoJMbXcvkJhxGqKP8mcTbqIkiSKEaamE5hnQFpzUbsmgnZVTINnft3Bu/9iQ8gcSS/sQ4VUy61kU0qIH2FITLntU0Nil0nHCaM3W+Mzmqv aks-ssh"
sku_tier                           = "Paid"

system_node_pool = {
  min_nodes = 50,
  max_nodes = 60
}
linux_node_pool = {
  min_nodes = 4,
  max_nodes = 10
}

availability_zones = []