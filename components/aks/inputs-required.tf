# General
variable "env" {}

variable "project" {}

variable "builtFrom" {}

variable "product" {}

# Remote State
variable "control_vault" {}

# Kubernetes
variable "kubernetes_cluster_ssh_key" {}

variable "clusters" {
  type        = map(map(string))
  description = <<-EOF
  Map of clusters to manage. Example:
  clusters = {
    "00" = {
      kubernetes_cluster_version = "1.22.6"
    },
    "01" = {
      kubernetes_cluster_version = "1.22.6"
    }
  }
  EOF
}

variable "kubernetes_cluster_agent_min_count" {
  default = 1
}
variable "kubernetes_cluster_agent_max_count" {
  default = 3
}
variable "kubernetes_cluster_agent_vm_size" {
  default = "Standard_DS3_v2"
}

# CFT specific
variable "project_acr_enabled" {
  default = false
}

variable "monitor_diagnostic_setting" {
  default = false
}

variable "kube_audit_admin_logs_enabled" {
  default = false
}

variable "monitor_diagnostic_setting_metrics" {
  default = false
}

variable "sku_tier" {
  default = "Standard"
}

variable "ptl_cluster" {
  default = false
}

variable "enable_user_system_nodepool_split" {
  default = false
}

variable "availability_zones" {
  type = list(any)
}

variable "enable_automatic_channel_upgrade_patch" {
  default     = false
  description = "Enable automatic patch upgrades"
}

variable "csi_driver_enabled" {
  default = true
}
