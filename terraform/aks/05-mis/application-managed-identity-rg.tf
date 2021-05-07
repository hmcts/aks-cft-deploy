# # Not needed for CFT, we currently use managed-identities-${var.environment}-rg to store all the application MI's
# resource "azurerm_resource_group" "application-mi" {
#   name     = "managed-identities-${var.environment}-rg"
#   location = var.location
#   tags     = local.common_tags
# }
