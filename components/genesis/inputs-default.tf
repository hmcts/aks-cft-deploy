locals {

  environment = (var.env == "aat") ? "stg" : (var.env == "perftest") ? "test" : (var.env == "preview") ? "dev" : var.env

  developers_group = "DTS CFT Developers"

  business_area = "cft"

}

variable "builtFrom" {
  default = "hmcts/aks-cft-deploy"
}

variable "product" {
  default = "cft-platform"
}

variable "expiresAfter" {
  default = "3000-01-01"
}
