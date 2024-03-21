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

variable "node_os_maintenance_window_config" {
  type = object({
    frequency   = string
    interval    = number
    duration    = number
    day_of_week = optional(string)
    start_time  = optional(string)
    utc_offset  = optional(string)
    start_date  = optional(string)
  })
  default = {
    frequency   = "Weekly"
    interval    = 1
    duration    = 4
    day_of_week = "Monday"
    start_time  = "18:00"
    utc_offset  = "+00:00"
    start_date  = null
  }
}