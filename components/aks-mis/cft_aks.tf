data "azurerm_resource_group" "managed-identity-operator-cft-mi" {
  provider = azurerm.acr
  name     = "managed-identities-${local.environment}-rg"
}

resource "azurerm_role_assignment" "uami_cft_rg_identity_operator" {
  count                = var.cluster_count
  provider             = azurerm.acr
  principal_id         = data.azurerm_kubernetes_cluster.kubernetes["${count.index}"].kubelet_identity[0].object_id
  scope                = data.azurerm_resource_group.managed-identity-operator-cft-mi.id
  role_definition_name = "Managed Identity Operator"
}

data "azurerm_kubernetes_cluster" "kubernetes" {
  count               = var.cluster_count
  name                = "${var.project}-${var.environment}-0${count.index}-${var.service_shortname}"
  resource_group_name = "${var.project}-${var.environment}-0${count.index}-rg"
}
