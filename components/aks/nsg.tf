# data "azurerm_resources" "aksnsg" {
#   resource_group_name = module.kubernetes.node_resource_group

#   type = "Microsoft.Network/networkSecurityGroups"
# }

# output "aks_nsg" {
#   value = data.azurerm_resources.aksnsg.resources.0.name
# }

data "azurerm_resources" "example" {
  resource_group_name = azurerm_resource_group.kubernetes_resource_group

  type = "Microsoft.Network/networkSecurityGroups"
}

output "aks-cluster-nsg" {
  value = data.azurerm_resources.example.resources.0.name
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
  resource_group_name         = azurerm_resource_group.kubernetes_resource_group
  network_security_group_name = data.azurerm_resources.example.resources.0.name
}
