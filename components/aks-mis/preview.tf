# Update -target in azure-pipelines.yaml

data "azurerm_resource_group" "managed-identity-preview1aat" {
  for_each = toset([for cluster in var.clusters : cluster if contains([var.env], "preview")])
  provider = azurerm.preview1aat
  name     = "managed-identities-aat-rg"
}

resource "azurerm_role_assignment" "preview1aat_cft_rg_identity_operator" {
  for_each             = toset([for cluster in var.clusters : cluster if contains([var.env], "preview")])
  provider             = azurerm.preview1aat
  principal_id         = module.kubernetes.kubelet_object_ids
  scope                = data.azurerm_resource_group.managed-identity-preview1aat[each.key].id
  role_definition_name = "Managed Identity Operator"
}
resource "azurerm_role_assignment" "preview2aat_cft_rg_identity_operator" {
  for_each             = toset([for cluster in var.clusters : cluster if contains([var.env], "preview")])
  provider             = azurerm.preview2aat
  principal_id         = module.kubernetes.kubelet_object_ids
  scope                = data.azurerm_resource_group.managed-identity-preview2aat[each.key].id
  role_definition_name = "Managed Identity Operator"
}

data "azurerm_resource_group" "managed-identity-preview2aat" {
  for_each = toset([for cluster in var.clusters : cluster if contains([var.env], "preview")])
  provider = azurerm.preview2aat
  name     = "managed-identities-aat-rg"
}


data "azurerm_user_assigned_identity" "sops_mi" {
  name                = "aks-${var.env}-mi"
  resource_group_name = "genesis-rg"
}

resource "azurerm_role_assignment" "preview_externaldns_read_rg" {
  count                = (contains(["preview"], var.env) ? 1 : 0)
  provider             = azurerm.dts-cftptl-intsvc
  principal_id         = data.azurerm_user_assigned_identity.sops_mi.principal_id
  scope                = "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg"
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "preview_externaldns_dns_zone_contributor" {
  count                = (contains(["preview"], var.env) ? 1 : 0)
  provider             = azurerm.dts-cftptl-intsvc
  principal_id         = data.azurerm_user_assigned_identity.sops_mi.principal_id
  scope                = "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/service.core-compute-preview.internal"
  role_definition_name = "Private DNS Zone Contributor"
}
