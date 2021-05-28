module "network" {
  source = "git::https://github.com/hmcts/aks-module-network.git?ref=cft"

  resource_group_name = local.network_resource_group_name

  route_next_hop_in_ip_address = local.hub[var.hub].ukSouth.next_hop_ip
  additional_routes            = var.additional_routes
  environment                  = var.environment

  network_address_space = var.network_address_space
  network_location      = var.location
  network_shortname     = local.network_shortname
  project               = var.project
  service_shortname     = var.service_shortname

  aks_00_subnet_cidr_blocks              = var.aks_00_subnet_cidr_blocks #UK South
  aks_01_subnet_cidr_blocks              = var.aks_01_subnet_cidr_blocks #UK West # Currently both clusters in UK South
  application_gateway_subnet_cidr_blocks = var.application_gateway_subnet_cidr_blocks
  iaas_subnet_cidr_blocks                = var.iaas_subnet_cidr_blocks
  additional_subnets                     = var.additional_subnets

  appgw_routetable = var.appgw_routetable
  additional_routes_appgw = var.additional_routes_appgw

  tags = module.ctags.common_tags
}

module "ctags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.environment
  product     = var.product
  builtFrom   = var.builtFrom
}