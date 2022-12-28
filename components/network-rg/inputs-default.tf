locals {

}

variable "location" {
  default = "uksouth"
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