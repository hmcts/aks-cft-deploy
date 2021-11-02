data "azurerm_resource_group" "managed-identity-preview1aat" {
  provider = azurerm.preview1aat
  name     = "managed-identities-aat-rg"
}

resource "azurerm_role_assignment" "preview1aat_cft_rg_identity_operator" {
  count                = contains(["preview"], var.environment) ? 1 : 0
  provider             = azurerm.preview1aat
  principal_id         = module.kubernetes["${var.cluster_count}"].kubelet_object_id
  scope                = data.azurerm_resource_group.managed-identity-preview1aat.id
  role_definition_name = "Managed Identity Operator"

  depends_on = [module.kubernetes]
}

data "azurerm_resource_group" "managed-identity-preview2aat" {
  provider = azurerm.preview2aat
  name     = "managed-identities-aat-rg"
}

resource "azurerm_role_assignment" "preview2aat_cft_rg_identity_operator" {
  count                = contains(["preview"], var.environment) ? 1 : 0
  provider             = azurerm.preview2aat
  principal_id         = module.kubernetes["${var.cluster_count}"].kubelet_object_id
  scope                = data.azurerm_resource_group.managed-identity-preview2aat.id
  role_definition_name = "Managed Identity Operator"

  depends_on = [module.kubernetes]
}