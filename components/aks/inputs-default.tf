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

variable "spot_node_pool" {
  description = "Map to override the spot node pool config"
  default     = {}
}

variable "kubernetes_cluster_agent_max_pods" {
  default = "30"
}

variable "oms_agent_enabled" {
  default = false
}

variable "expiresAfter" {
  default = "3000-01-01"
}

variable "autoShutdown" {
  default = false
}

variable "startupMode" {
  default = null
}