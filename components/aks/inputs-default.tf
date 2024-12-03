locals {

}

variable "location" {
  default = "uksouth"
}

variable "spot_node_pool" {
  description = "Map to override the spot node pool config"
  default     = {}
}

variable "service_shortname" {
  default = "aks"
}

variable "kubernetes_cluster_agent_max_pods" {
  default = "30"
}

variable "expiresAfter" {
  default = "3000-01-01"
}


variable "startupMode" {
  default = null
}

variable "drain_timeout_time" {
  default = 0
}

variable "node_os_maintenance_window_config" {
  type = object({
    frequency   = optional(string, "Weekly")
    interval    = optional(number, 1)
    duration    = optional(number, 4)
    day_of_week = optional(string, "Monday")
    start_time  = optional(string, "23:00")
    utc_offset  = optional(string, "+00:00")
    start_date  = optional(string, null)
    is_prod     = optional(bool, true)
  })
  default = {}
}

