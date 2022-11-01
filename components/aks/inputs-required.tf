# General
variable "env" {}

variable "project" {}

variable "builtFrom" {}

variable "product" {}

# Remote State
variable "control_vault" {}

# Kubernetes
variable "kubernetes_cluster_ssh_key" {}

variable "kubernetes_cluster_agent_min_count" {
  default = 1
}
variable "kubernetes_cluster_agent_max_count" {
  default = 3
}
variable "kubernetes_cluster_agent_vm_size" {
  default = "Standard_DS3_v2"
}

variable "kubernetes_cluster_version" {}

variable "cluster_count" {}

# CFT specific
variable "project_acr_enabled" {
  default = false
}

variable "monitor_diagnostic_setting" {
  default = true
}

variable "sku_tier" {
  default = "Paid"
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

variable "workload_identity_enabled" {
  default = false
}

variable "service_operator_settings_enabled" {
  default = false
}