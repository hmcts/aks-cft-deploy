data "azurerm_subscription" "current" {
}

data "azurerm_client_config" "current" {
}

data "azurerm_resource_group" "genesis_rg" {
  name = "genesis-rg"
}

data "azurerm_subscription" "subscription" {}
data "azurerm_user_assigned_identity" "aks" {
  name                = "aks-${var.env}-mi"
  resource_group_name = data.azurerm_resource_group.genesis_rg.name
}

locals {

  environment = (var.env == "perftest") ? "test" : (var.env == "aat") ? "stg" : (var.env == "preview") ? "dev" : "${var.env}"

}

data "azurerm_key_vault" "genesis_keyvault" {
  name                = contains(["ptlsbox", "ptl"], var.env) ? "dts${var.project}${replace(var.env, "-", "")}" : "${lower(replace(data.azurerm_subscription.current.display_name, "-", ""))}kv"
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
