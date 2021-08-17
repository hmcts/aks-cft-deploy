# General
variable "environment" {}

variable "enable_debug" {}

variable "control_vault" {}

variable "project" {}

variable "hub" {}

variable "private_dns_subscription" {}

variable "private_dns_zones" {}

# Network
variable "network_address_space" {}

variable "aks_00_subnet_cidr_blocks" {}

variable "aks_01_subnet_cidr_blocks" {}

variable "iaas_subnet_cidr_blocks" {}

variable "application_gateway_subnet_cidr_blocks" {}

variable "resource_group_name" {
}
