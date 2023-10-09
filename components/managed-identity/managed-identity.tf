resource "azurerm_user_assigned_identity" "sops-mi" {
  resource_group_name = data.azurerm_resource_group.genesis_rg.name
  location            = data.azurerm_resource_group.genesis_rg.location

  name = "aks-${var.env}-mi"
  tags = module.ctags.common_tags
}

resource "azurerm_role_assignment" "MI-Operator" {
  # DTS Bootstrap Principal_id
  principal_id         = azurerm_user_assigned_identity.sops-mi.principal_id
  role_definition_name = "Managed Identity Operator"
  scope                = azurerm_user_assigned_identity.sops-mi.id
}

resource "azurerm_role_assignment" "Reader" {
  # DTS Bootstrap Principal_id
  principal_id         = azurerm_user_assigned_identity.sops-mi.principal_id
  role_definition_name = "Reader"
  scope                = data.azurerm_key_vault.genesis_keyvault.id
}

resource "azurerm_key_vault_key" "sops-key" {
  name         = "sops-key"
  key_vault_id = data.azurerm_key_vault.genesis_keyvault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
  ]
}

resource "azurerm_key_vault_access_policy" "sops-policy" {
  key_vault_id = data.azurerm_key_vault.genesis_keyvault.id

  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azurerm_user_assigned_identity.sops-mi.principal_id

  key_permissions = [
    "Get",
    "Encrypt",
    "Decrypt",
    "List",
  ]

  secret_permissions = [
    "Get",
    "List",
  ]
}

locals {
  acme_environment_rg  = var.env == "sandbox" ? "sbox" : var.env == "preview" ? "dev" : var.env == "perftest" ? "test" : var.env == "aat" ? "stg" : var.env
  acme_environment_kv  = var.env == "ptl" ? "ptlintsvc" : var.env == "sandbox" ? "sbox" : var.env == "preview" ? "dev" : var.env == "ptlsbox" ? "sboxintsvc" : var.env == "perftest" ? "test" : var.env == "aat" ? "stg" : var.env
  department_name      = var.env == "ptl" || var.env == "ptlsbox" ? "dts" : "dcd"
  acme_environment_app = var.env == "ptl" || var.env == "ptlsbox" ? "cft" : "cftapps"
  wi_environment_rg    = var.env == "sbox" ? "sandbox" : var.env == "ptlsbox" ? "cftsbox-intsvc" : var.env == "ptl" ? "cftptl-intsvc" : var.env == "preview" ? "aat" : var.env

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

  # MIs for managed-identities-sandbox-rg etc - for workload identity with ASO
  mi_cft = {
    # DCD-CNP-Sandbox
    sbox = {
      subscription_id = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
    }
    # DCD-CNP-DEV
    aat = {
      subscription_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
    demo = {
      subscription_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
    preview = {
      subscription_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
    # DCD-CNP-QA
    ithc = {
      subscription_id = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
    }
    perftest = {
      subscription_id = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
    }
    # DCD-CNP-Prod
    prod = {
      subscription_id = "8999dec3-0104-4a27-94ee-6588559729d1"
    }
    # DTS-CFTSBOX-INTSVC
    ptlsbox = {
      subscription_id = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
    }
    # DTS-CFTPTL-INTSVC
    ptl = {
      subscription_id = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
    }
  }
}

data "azurerm_resource_group" "platform-rg" {
  name = "cft-platform-${local.acme_environment_rg}-rg"
}

data "azurerm_key_vault" "acme" {
  name                = "acme${local.department_name}${local.acme_environment_app}${local.acme_environment_kv}"
  resource_group_name = data.azurerm_resource_group.platform-rg.name
}

data "azurerm_resource_group" "cftapps-mi-rg" {
  provider = azurerm.managed_identity_infra_sub
  name     = "managed-identities-${local.wi_environment_rg}-rg"
}

resource "azurerm_user_assigned_identity" "wi-admin-mi" {
  provider            = azurerm.managed_identity_infra_sub
  resource_group_name = data.azurerm_resource_group.cftapps-mi-rg.name
  location            = data.azurerm_resource_group.cftapps-mi-rg.location

  name = "admin-${local.wi_environment_rg}-mi"
  tags = module.ctags.common_tags
}

resource "azurerm_role_assignment" "acme-vault-access" {
  for_each             = toset([azurerm_user_assigned_identity.sops-mi.principal_id, azurerm_user_assigned_identity.wi-admin-mi.principal_id])
  scope                = data.azurerm_key_vault.acme.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = each.key
}

resource "azurerm_role_assignment" "externaldns_dns_zone_contributor" {
  for_each             = lookup(local.external_dns, var.env, toset([]))
  scope                = each.value
  role_definition_name = contains(regex("^.*/Microsoft.Network/(.*)/.*$", each.value), "privateDnsZones") ? "Private DNS Zone Contributor" : "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.sops-mi.principal_id
}

resource "azurerm_role_assignment" "externaldns_read_rg" {
  # Only add the reader role if there are zones configured
  for_each             = lookup(local.external_dns, var.env, null) != null ? local.external_dns.resource_groups : toset([])
  scope                = each.value
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.sops-mi.principal_id
}

resource "azurerm_role_assignment" "preview_mi" {
  count                = var.env == "preview" ? 1 : 0
  principal_id         = data.azurerm_user_assigned_identity.aks.principal_id
  scope                = "/subscriptions/1c4f0704-a29e-403d-b719-b90c34ef14c9"
  role_definition_name = "Contributor"
}
module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}