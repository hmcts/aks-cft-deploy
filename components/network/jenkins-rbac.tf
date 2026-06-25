data "azurerm_user_assigned_identity" "jenkins_aat_mi" {
  count = var.env == "aat" ? 1 : 0

  provider            = azurerm.core-infra-routetable
  name                = "jenkins-aat-mi"
  resource_group_name = "managed-identities-aat-rg"
}

resource "azurerm_role_assignment" "jenkins_aat_mi_ptl_network_reader" {
  count = var.env == "aat" ? 1 : 0

  provider             = azurerm.private-dns-private-endpoint
  principal_id         = data.azurerm_user_assigned_identity.jenkins_aat_mi[0].principal_id
  scope                = "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/cft-ptl-network-rg"
  role_definition_name = "Reader"
}

resource "azurerm_role_assignment" "jenkins_aat_mi_preview_network_reader" {
  count = var.env == "aat" ? 1 : 0

  provider             = azurerm.cftapps-dev
  principal_id         = data.azurerm_user_assigned_identity.jenkins_aat_mi[0].principal_id
  scope                = "/subscriptions/8b6ea922-0862-443e-af15-6056e1c9b9a4/resourceGroups/cft-preview-network-rg"
  role_definition_name = "Reader"
}
