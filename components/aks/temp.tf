data "azurerm_resource_group" "managed-identity-operator-cft-mi" {
  provider = azurerm.acr
  name     = "managed-identities-${local.environment}-rg"
}

data "azurerm_resource_group" "managed-identity-preview1aat" {
  provider = azurerm.preview1aat
  name     = "managed-identities-aat-rg"
}

data "azurerm_resource_group" "managed-identity-preview2aat" {
  provider = azurerm.preview2aat
  name     = "managed-identities-aat-rg"
}