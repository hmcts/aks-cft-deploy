locals {

  developers_group = "DTS Operations (env:sbox)"

  criticality = {
    sbox     = "Low"
    aat      = "High"
    stg      = "High"
    prod     = "High"
    ithc     = "Medium"
    test     = "Medium"
    perftest = "Medium"
    demo     = "Medium"
    dev      = "Low"
  }

  env_display_names = {
    sbox     = "Sandbox"
    aat      = "Staging"
    stg      = "Staging"
    prod     = "Production"
    ithc     = "ITHC"
    test     = "Test"
    perftest = "Test"
    dev      = "Development"
    demo     = "Demo"
  }

  common_tags = {
    "managedBy"          = "PlatformEngineering"
    "solutionOwner"      = "CFT"
    "activityName"       = "AKS"
    "dataClassification" = "Internal"
    "automation"         = "cft-aks-deploy"
    "costCentre"         = "10245117" // until we get a better one, this is the generic cft contingency one
    "environment"        = local.env_display_names[var.environment]
    "criticality"        = local.criticality[var.environment]
  }
}
