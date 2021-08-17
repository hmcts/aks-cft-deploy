resource "azurerm_route_table" "routetable" {
  name                = "aks-aat-core-infra-route-table"
  location            = var.location
  resource_group_name = module.network.resource_group_name

  disable_bgp_route_propagation = false

  route {
    name                   = "aks-00"
    address_prefix         = "10.10.128.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  }

  route {
    name                   = "aks-01"
    address_prefix         = "10.10.144.0/20"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.11.8.36"
  }

  tags = module.ctags.common_tags
}

module "ctags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.environment
  product     = var.product
  builtFrom   = var.builtFrom
}