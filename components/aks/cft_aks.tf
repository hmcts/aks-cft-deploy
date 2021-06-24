data "azurerm_resource_group" "managed-identity-operator-cft-mi" {
  provider = azurerm.acr
  name     = "managed-identities-${local.environment}-rg"
}

resource "azurerm_role_assignment" "uami_cft_rg_identity_operator" {
  count  = var.cluster_count
  provider             = azurerm.acr
  principal_id         = module.kubernetes["${count.index}"].kubelet_object_ids
  scope                = data.azurerm_resource_group.managed-identity-operator-cft-mi.id
  role_definition_name = "Managed Identity Operator"

  depends_on = [module.kubernetes]
}