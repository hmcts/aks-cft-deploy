data "azurerm_resource_group" "managed-identity-operator-cft-mi" {
  provider = azurerm.acr
  name     = "managed-identities-${local.environment}-rg"
}
