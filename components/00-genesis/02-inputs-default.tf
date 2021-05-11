locals {

  developers_group = "DTS Operations (env:sbox)"

}

variable "builtFrom" {
  default = "hmcts/aks-cft-deploy"
}

variable "product" {
  default = "cft-platform"
}