data "azurerm_resource_group" "managed-identity-operator-cft-mi" {
  provider = azurerm.acr
  name     = "managed-identities-${local.environment}-rg"
}

resource "azurerm_role_assignment" "uami_cft_rg_identity_operator" {
  for_each             = module.kubernetes.kubelet_object_ids
  provider             = azurerm.acr
  principal_id         = each.key
  scope                = data.azurerm_resource_group.managed-identity-operator-cft-mi.id
  role_definition_name = "Managed Identity Operator"

    depends_on = [module.kubernetes[*]]
}