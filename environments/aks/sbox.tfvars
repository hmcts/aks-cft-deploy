cluster_count                      = 2
kubernetes_cluster_version         = "1.19.11"
kubernetes_cluster_agent_min_count = "6"
kubernetes_cluster_agent_max_count = "15"
kubernetes_cluster_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCeRwSzSKJfjmIVQ6CUld/M3vF9Hcfxh5cLBa1BV+UZDh5p1gKoB0xRegSFdncfup1qMAhrZtgBpaclLiYUfe8ZajPp1Lmva9AJuK/UktzF9stZie7LDpflEdVBXlSZw3AtAWxF2vIkEeW+NVYlGAJOQlasFkmGTkco+O1wUM4LGI3YNHm7r70rnmHT2djoR1t4x1jlPCrXaJEhvtyxf01Dwjq2nWaox3puJtHs5DLFpEIvXvHwQWssFFyKIuwkm4FewHKJSbCahyaCb+ac10MAZg9vZnWq0EYOe1nLn7c3538yJ9WJh7jRFZDza6ab9HVb5hgJ3/t/K+EzkU/XGSEJ"
enable_user_system_nodepool_split  = true
project_acr_enabled                = true
sku_tier                           = "Paid"

system_node_pool = {
  min_nodes = 2,
  max_nodes = 4
}
linux_node_pool = {
  min_nodes = 4,
  max_nodes = 10
}