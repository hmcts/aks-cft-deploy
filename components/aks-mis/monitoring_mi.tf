resource "azurerm_user_assigned_identity" "monitoring-mi" {
  resource_group_name = "managed-identities-${local.environment}-rg"
  location            = var.location
  provider = azurerm.acr

  name = "monitoring-${var.env}-mi"
  tags = module.ctags.common_tags
}

data "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "pipeline-metrics"
  resource_group_name = "pipelinemetrics-database-prod"
  provider = azurerm.global_acr
}

resource "azurerm_cosmosdb_sql_role_assignment" "data-contributor" {
  resource_group_name = data.azurerm_cosmosdb_account.cosmosdb.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.cosmosdb.name
  # Cosmos DB Built-in Data Contributor
  role_definition_id = "${data.azurerm_cosmosdb_account.cosmosdb.id}/sqlRoleDefinitions/00000000-0000-0000-0000-000000000002"
  principal_id       = azurerm_user_assigned_identity.monitoring-mi.principal_id
  scope              = data.azurerm_cosmosdb_account.cosmosdb.id
}

module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}

