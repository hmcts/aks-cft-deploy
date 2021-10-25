locals {

}

variable "location" {
  default = "uksouth"
}

variable "service_shortname" {
  default = "aks"
}

variable "system_node_pool" {
  description = "Map to override the system node pool config"
}

variable "linux_node_pool" {
  description = "Map to override the linux node pool config"

}

variable "kubernetes_cluster_agent_max_pods" {
  default = "30"
}