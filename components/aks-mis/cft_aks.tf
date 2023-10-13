data "azurerm_kubernetes_cluster" "kubernetes" {
  for_each            = toset(var.clusters)
  name                = "${var.project}-${var.env}-${each.key}-${var.service_shortname}"
  resource_group_name = "${var.project}-${var.env}-${each.key}-rg"
}
