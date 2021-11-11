data "azurerm_resources" "example" {
  resource_group_name = module.kubernetes.kubernetes_cluster.node_resource_group

  type = "Microsoft.Network/networkSecurityGroups"
}

resource "azurerm_network_security_rule" "aks-cluster-nsg-rules" {
  for_each                    = var.aks_cluster_nsg_rules
  name                        = each.key
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = data.azurerm_resources.example.resource_group_name
  network_security_group_name = data.azurerm_resources.example.resources.0.name
}
