resource "azurerm_route_table" "route_table" {
  name = format("%s-%s-route-table",
    var.service_shortname,
    var.environment
  )

  location            = var.network_location
  resource_group_name = var.resource_group_name
  tags                = module.ctags.common_tags
}

resource "azurerm_route" "default_route" {
  name                   = var.route_name
  route_table_name       = azurerm_route_table.route_table.name
  resource_group_name    = var.resource_group_name
  address_prefix         = var.route_address_prefix
  next_hop_type          = var.route_next_hop_type
  next_hop_in_ip_address = var.route_next_hop_in_ip_address
}

resource "azurerm_route" "additional_route" {
  for_each = { for route in var.additional_routes : route.name => route }

  name                   = lower(each.value.name)
  route_table_name       = azurerm_route_table.route_table.name
  resource_group_name    = var.resource_group_name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_type != "VirtualAppliance" ? null : each.value.next_hop_in_ip_address
}
