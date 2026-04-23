locals {
  # MIs for managed-identities-sandbox-rg etc - for workload identity with ASO
  mi_cft = {
    # DCD-CNP-Sandbox
    sbox = {
      subscription_id = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
      mi_name         = "cft-${local.environment}-jenkins-mi"
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
  jenkins_mi_name = coalesce(
    contains(["ptlsbox"], local.environment) ? "jenkins-cftsbox-intsvc-mi" : null,
    contains(["ptl"], local.environment) ? "jenkins-cftptl-intsvc-mi" : null,
    "jenkins-${local.environment}-mi"
  )
  jenkins_mi_rg_name = coalesce(
    contains(["ptlsbox"], local.environment) ? "managed-identities-cftsbox-intsvc-rg" : null,
    contains(["ptl"], local.environment) ? "managed-identities-cftptl-intsvc-rg" : null,
    "managed-identities-${local.environment}-rg"
  )
}

module "genesis" {
  source                  = "git::https://github.com/hmcts/aks-module-genesis.git?ref=dtspo-30482-grant-per-env-jenkins-mi-on-kv"
  environment             = local.environment
  tags                    = module.ctags.common_tags
  developers_group        = local.developers_group
  business_area           = lower(module.ctags.common_tags["businessArea"])
  jenkins_provider_sub_id = local.mi_cft[local.environment].subscription_id
  jenkins_mi_name         = local.jenkins_mi_name
  jenkins_mi_rg_name      = local.jenkins_mi_rg_name
}

module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
}