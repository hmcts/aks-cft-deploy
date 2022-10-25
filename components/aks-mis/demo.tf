# Update -target in azure-pipelines.yaml
data "azurerm_user_assigned_identity" "sops_demo_mi" {
  name                = "aks-${var.environment}-mi"
  resource_group_name = "genesis-rg"
}

locals {
  external_dns = {
    # Resource Groups to add Reader permissions for external dns to
    resource_groups = toset([
      "/subscriptions/ed302caf-ec27-4c64-a05e-85731c3ce90e/resourceGroups/reformMgmtRG",
      "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg"
    ])
    # Demo DNS zones to add "DNS Zone Contributor" premissions for external dns to
    demo = toset([
      "/subscriptions/ed302caf-ec27-4c64-a05e-85731c3ce90e/resourceGroups/reformMgmtRG/providers/Microsoft.Network/dnszones/demo.platform.hmcts.net",
      "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/demo.platform.hmcts.net",
      "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/service.core-compute-demo.internal",
      "/subscriptions/1baf5470-1c3e-40d3-a6f7-74bfbce4b348/resourceGroups/core-infra-intsvc-rg/providers/Microsoft.Network/privateDnsZones/service.core-compute-idam-demo.internal"
    ])
  }
}

resource "azurerm_role_assignment" "externaldns_dns_zone_contributor" {
  for_each             = lookup(local.external_dns, var.environment, toset([]))
  scope                = each.value
  role_definition_name = contains(regex("^.*/Microsoft.Network/(.*)/.*$", each.value), "privateDnsZones") ? "Private DNS Zone Contributor" : "DNS Zone Contributor"
  principal_id         = data.azurerm_user_assigned_identity.sops_demo_mi.principal_id
}

resource "azurerm_role_assignment" "externaldns_read_rg" {
  # Only add the reader role if there are zones configured
  for_each             = lookup(local.external_dns, var.environment, null) != null ? local.external_dns.resource_groups : toset([])
  scope                = each.value
  role_definition_name = "Reader"
  principal_id         = data.azurerm_user_assigned_identity.sops_demo_mi.principal_id
}
