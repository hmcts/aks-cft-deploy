locals {
  jenkins-mi = (var.env == "sbox") ? "cftsbox" : "cftptl"

  jenkins = {

    # cftptl = {
    #   subscription = "5ca62022-6aa2-4cee-aaa7-e7536c8d566c"
    #   mi = "jenkins-cftptl-intsvc-mi"
    # }
    cftsbox = {
      subscription = "8999dec3-0104-4a27-94ee-6588559729d1"
      mi           = "jenkins-cftsbox-intsvc-mi"
    }
  }

}

provider "azurerm" {
  alias                      = "jenkins-mi"
  skip_provider_registration = "true"
  features {}
  subscription_id = local.jenkins[local.jenkins-mi].subscription
}


data "azurerm_user_assigned_identity" "jenkins-mi" {
  provider            = azurerm.jenkins-mi
  name                = "jenkins-${local.jenkins-mi}-intsvc-mi"
  resource_group_name = "managed-identities-${local.jenkins-mi}-intsvc-rg"
}

resource "azurerm_role_assignment" "jenkins-mi-Reader" {
  # DTS Bootstrap Principal_id
  principal_id         = data.azurerm_user_assigned_identity.jenkins-mi.principal_id
  role_definition_name = "Reader"
  scope                = data.azurerm_key_vault.genesis_keyvault.id
}

resource "azurerm_key_vault_access_policy" "jenkins-mi-policy" {
  key_vault_id = data.azurerm_key_vault.genesis_keyvault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_user_assigned_identity.jenkins-mi.principal_id

  secret_permissions = [
    "get",
    "list",
  ]
}