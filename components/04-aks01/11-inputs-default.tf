locals {

}

variable "location" {
  default = "uksouth"
}

variable "service_shortname" {
  default = "aks"
}

variable "builtFrom" {
  default = "hmcts/aks-cft-deploy"
}

variable "product" {
  default = "cft-platform"
}

variable "kubernetes_cluster_agent_max_pods" {
  default = "30"
}

variable "project_acr_enabled" {
  default = false
}