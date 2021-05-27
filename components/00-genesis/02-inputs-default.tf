locals {

  environment = (var.environment == "aat") ? "stg" : "${(var.environment == "perftest") ? "test" : "${var.environment}"}"

  developers_group = "DTS Operations (env:${local.environment})"

}

variable "builtFrom" {
  default = "hmcts/aks-cft-deploy"
}

variable "product" {
  default = "cft-platform"
}