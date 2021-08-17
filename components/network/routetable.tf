resource "azurerm_route_table" "route_table" {
  name = format("%s-%s-core-infra-route-table",
    var.service_shortname,
    var.environment
  )

  provider = azurerm.core-infra-routetable

  location            = var.location
  resource_group_name = "core-infra-${var.environment}"
  tags                = module.ctags.common_tags
}

resource "azurerm_route" "default_route" {
  name                   = var.route_name
  route_table_name       = azurerm_route_table.route_table.name
  resource_group_name    = "core-infra-${var.environment}"
  address_prefix         = var.route_address_prefix
  next_hop_type          = var.route_next_hop_type
  next_hop_in_ip_address = var.route_next_hop_in_ip_address

  provider = azurerm.core-infra-routetable
}

resource "azurerm_route" "additional_route" {
  for_each = { for route in var.additional_routes : route.name => route }

  name                   = lower(each.value.name)
  route_table_name       = azurerm_route_table.route_table.name
  resource_group_name    = "core-infra-${var.environment}"
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_type != "VirtualAppliance" ? null : each.value.next_hop_in_ip_address

  provider = azurerm.core-infra-routetable

}
