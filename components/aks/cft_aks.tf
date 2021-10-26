data "azurerm_resource_group" "managed-identity-operator-cft-mi" {
  provider = azurerm.acr
  name     = "managed-identities-${local.environment}-rg"
}

# resource "azurerm_role_assignment" "uami_cft_rg_identity_operator" {
#   count                = var.cluster_count
#   provider             = azurerm.acr
#   principal_id         = module.kubernetes["${count.index}"].kubelet_object_id
#   scope                = data.azurerm_resource_group.managed-identity-operator-cft-mi.id
#   role_definition_name = "Managed Identity Operator"

#   depends_on = [module.kubernetes]
# }

# data "azurerm_resource_group" "managed-identity-operator-cft" {
#   name = "managed-identities-${local.environment-mi}-rg"

# }

# resource "azurerm_role_assignment" "uami_cft_rg_identity_operator2" {
#   count                = var.cluster_count
#   principal_id         = module.kubernetes["${count.index}"].kubelet_object_id
#   scope                = data.azurerm_resource_group.managed-identity-operator-cft.id
#   role_definition_name = "Managed Identity Operator"

#   depends_on = [module.kubernetes]
# }