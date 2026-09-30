locals {
  jenkins_environment_mis = {
    aat = {
      name                = "jenkins-aat-mi"
      resource_group_name = "managed-identities-aat-rg"
    }
    demo = {
      name                = "jenkins-demo-mi"
      resource_group_name = "managed-identities-demo-rg"
    }
    ithc = {
      name                = "jenkins-ithc-mi"
      resource_group_name = "managed-identities-ithc-rg"
    }
    perftest = {
      name                = "jenkins-perftest-mi"
      resource_group_name = "managed-identities-perftest-rg"
    }
    preview = {
      name                = "jenkins-preview-mi"
      resource_group_name = "managed-identities-preview-rg"
    }
    prod = {
      name                = "jenkins-prod-mi"
      resource_group_name = "managed-identities-prod-rg"
    }
    ptl = {
      name                = "jenkins-cftptl-intsvc-mi"
      resource_group_name = "managed-identities-cftptl-intsvc-rg"
    }
    ptlsbox = {
      name                = "jenkins-cftsbox-intsvc-mi"
      resource_group_name = "managed-identities-cftsbox-intsvc-rg"
    }
    sbox = {
      name                = "jenkins-sbox-mi"
      resource_group_name = "managed-identities-sandbox-rg"
    }
  }
}

data "azurerm_user_assigned_identity" "jenkins_environment_mi" {
  provider            = azurerm.acr
  name                = local.jenkins_environment_mis[var.env].name
  resource_group_name = local.jenkins_environment_mis[var.env].resource_group_name
}

data "azurerm_virtual_network" "jenkins_environment_mi_network" {
  name                = local.network_name
  resource_group_name = local.network_resource_group_name
}

resource "azurerm_role_assignment" "jenkins_environment_mi_aks_admin" {
  for_each             = var.clusters
  principal_id         = data.azurerm_user_assigned_identity.jenkins_environment_mi.principal_id
  role_definition_name = "Azure Kubernetes Service Cluster Admin Role"
  scope                = "${azurerm_resource_group.kubernetes_resource_group[each.key].id}/providers/Microsoft.ContainerService/managedClusters/${var.project}-${var.env}-${each.key}-${var.service_shortname}"

  depends_on = [module.kubernetes]
}

resource "azurerm_role_assignment" "jenkins_environment_mi_network_contributor" {
  principal_id         = data.azurerm_user_assigned_identity.jenkins_environment_mi.principal_id
  role_definition_name = "Network Contributor"
  scope                = data.azurerm_virtual_network.jenkins_environment_mi_network.id
}
