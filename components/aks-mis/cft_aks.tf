data "azurerm_resource_group" "managed-identity-operator-cft-mi" {
  provider = azurerm.acr
  name     = "managed-identities-${local.environment}-rg"
}

resource "azurerm_role_assignment" "uami_cft_rg_identity_operator" {
  for_each             = toset(var.clusters)
  provider             = azurerm.acr
  principal_id         = module.kubernetes.kubelet_object_ids
  scope                = data.azurerm_resource_group.managed-identity-operator-cft-mi.id
  role_definition_name = "Managed Identity Operator"

  depends_on = [
    module.kubernetes
  ]

}

# data "azurerm_kubernetes_cluster" "kubernetes" {
#   for_each            = toset(var.clusters)
#   name                = "${var.project}-${var.env}-${each.key}-${var.service_shortname}"
#   resource_group_name = "${var.project}-${var.env}-${each.key}-rg"
# }
