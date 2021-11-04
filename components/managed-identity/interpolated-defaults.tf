data "azurerm_subscription" "current" {
}

data "azurerm_client_config" "current" {
}

data "azurerm_resource_group" "genesis_rg" {
  name = "genesis-rg"
}

locals {

  environment = (var.environment == "perftest") ? "test" : (var.environment == "aat") ? "stg" : (var.environment == "ptlsbox") ? "sbox" : (var.environment == "ptl") ? "prod" : "${var.environment}"

}

data "azurerm_key_vault" "genesis_keyvault" {
  name                = contains(["ptlsbox", "ptl"], var.environment) ? "dts${var.project}${replace(var.environment, "-", "")}" : "${lower(replace(data.azurerm_subscription.current.display_name, "-", ""))}kv"
  resource_group_name = data.azurerm_resource_group.genesis_rg.name
}

data "azurerm_key_vault" "hmcts_access_vault" {
  provider            = azurerm.hmcts-control
  name                = var.control_vault
  resource_group_name = "azure-control-${local.environment}-rg"
}

data "azurerm_key_vault_secret" "kubernetes_cluster_client_id" {
  provider     = azurerm.hmcts-control
  name         = "sp-object-id"
  key_vault_id = data.azurerm_key_vault.hmcts_access_vault.id
}
