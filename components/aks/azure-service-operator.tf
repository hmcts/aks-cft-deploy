data "azurerm_user_assigned_identity" "sops_mi" {
  name                = "aks-${var.environment}-mi"
  resource_group_name = "genesis-rg"
}

resource "azurerm_role_assignment" "Contributor" {
  principal_id         = data.azurerm_user_assigned_identity.sops_mi.principal_id
  role_definition_name = "Contributor"
  scope                = data.azurerm_subscription.current.id
}

resource "azapi_resource" "federated_identity_credential" {
  schema_validation_enabled = false
  name                      = "aso-federated-credential"
  parent_id                 = data.azurerm_user_assigned_identity.sops_mi.principal_id
  type                      = "Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials@2022-01-31-preview"

  location = var.location
  body = jsonencode({
    properties = {
      issuer    = module.kubernetes.oidc_issuer_url
      subject   = "system:serviceaccount:azureserviceoperator-system:azureserviceoperator-system"
      audiences = ["api://AzureADTokenExchange"]
    }
  })
  lifecycle {
    ignore_changes = [location]
  }
}