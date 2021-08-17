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

variable "route_name" {}

variable "route_address_prefix" {}

variable "route_next_hop_type" {}

variable "route_next_hop_in_ip_address" {}
