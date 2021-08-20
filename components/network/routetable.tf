resource "azurerm_route_table" "route_table_coreinfra" {
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
  for_each = { for route in var.additional_routes_coreinfra : route.name => route }

  name                   = lower(each.value.name)
  route_table_name       = azurerm_route_table.route_table_coreinfra.name
  resource_group_name    = "core-infra-${var.environment}"
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = each.value.next_hop_in_ip_address

  provider = azurerm.core-infra-routetable
}

resource "azurerm_subnet_route_table_association" "coreinfra_subnets" {
  for_each = { for subnet in var.coreinfra_subnets : subnet.name => subnet }

  subnet_id      = each.value.name.id
  route_table_id = azurerm_route_table.route_table_coreinfra.id
}
