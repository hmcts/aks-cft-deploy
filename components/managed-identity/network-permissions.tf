data "azurerm_virtual_network" "network" {
  name = format("%s-%s-vnet",
    var.project,
    var.env
  )
  resource_group_name = format("%s-%s-network-rg",
    var.project,
    var.env
  )
}

resource "azurerm_role_assignment" "network_access" {
  principal_id         = azurerm_user_assigned_identity.sops-mi.principal_id
  role_definition_name = "Network Contributor"
  scope                = data.azurerm_virtual_network.network.id
}

resource "azurerm_role_assignment" "hub_nonprod_intsvc_network_contributor" {
  count                = !contains(["prod", "ptl", "aat"], var.env) ? 1 : 0
  # EA: DTS Bootstrap (sub:hmcts-hub-nonprod-intsvc)
  principal_id         = "1708cfd4-75b3-44a3-943b-4526840772c2"
  role_definition_name = "Network Contributor"
  scope                = data.azurerm_virtual_network.network.id
}
