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

resource "azurerm_route" "coreinfra_routes" {
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
  for_each = { for subnet_id in var.coreinfra_subnets : subnet_id.subnet_id => subnet_id }

  route_table_id = azurerm_route_table.route_table_coreinfra.id
  subnet_id      = each.value.subnet_id
}

resource "azurerm_subnet_route_table_association" "coreinfra_subnets" {
  for_each = { for subnet in var.coreinfra_subnets : subnet.name => subnet }

  route_table_id = azurerm_route_table.route_table_coreinfra.id
  subnet_id      = data.azurerm_subnet.coreinfra_subnets[each.value.name].id
  provider       = azurerm.core-infra-routetable
}