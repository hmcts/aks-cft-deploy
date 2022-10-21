
# data "azurerm_resource_group" "managed-identity-demo" {
#   provider = azurerm.cft-demo
#   name     = "managed-identities-demo-rg"
# }

# resource "azurerm_role_assignment" "demo_cft_rg_identity_operator" {
#   count                = (contains(["demo"], var.environment) ? 1 : 0) * var.cluster_count
#   provider             = azurerm.cft-demo
#   principal_id         = data.azurerm_kubernetes_cluster.kubernetes["${count.index}"].kubelet_identity[0].object_id
#   scope                = data.azurerm_resource_group.managed-identity-demo.id
#   role_definition_name = "Managed Identity Operator"
# }

data "azurerm_user_assigned_identity" "sops_demo_mi" {
  name                = "aks-${var.environment}-mi"
  resource_group_name = "genesis-rg"
}

resource "azurerm_role_assignment" "demo_externaldns_read_rg" {
  count                = (contains(["demo"], var.environment) ? 1 : 0) * var.cluster_count
  provider             = azurerm.dts-cftptl-intsvc
  principal_id         = data.azurerm_user_assigned_identity.sops_demo_mi.principal_id
  scope                = "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg"
  role_definition_name = "Reader"
}
resource "azurerm_role_assignment" "demo_externaldns_private_dns_zone_contributor" {
  count                = (contains(["demo"], var.environment) ? 1 : 0) * var.cluster_count
  provider             = azurerm.dts-cftptl-intsvc
  principal_id         = data.azurerm_user_assigned_identity.sops_demo_mi.principal_id
  scope                = "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/demo.platform.hmcts.net"
  role_definition_name = "Private DNS Zone Contributor"
}

resource "azurerm_role_assignment" "demo_externaldns_read_rg_reform" {
  count                = (contains(["demo"], var.environment) ? 1 : 0) * var.cluster_count
  provider             = azurerm.reformmgmt
  principal_id         = data.azurerm_user_assigned_identity.sops_demo_mi.principal_id
  scope                = "/subscriptions/ed302caf-ec27-4c64-a05e-85731c3ce90e/resourceGroups/reformMgmtRG"
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "demo_externaldns_dns_zone_contributor_reform" {
  count                = (contains(["demo"], var.environment) ? 1 : 0) * var.cluster_count
  provider             = azurerm.reformmgmt
  principal_id         = data.azurerm_user_assigned_identity.sops_demo_mi.principal_id
  scope                = "/subscriptions/ed302caf-ec27-4c64-a05e-85731c3ce90e/resourceGroups/reformMgmtRG/providers/Microsoft.Network/dnszones/demo.platform.hmcts.net"
  role_definition_name = "DNS Zone Contributor"
}
