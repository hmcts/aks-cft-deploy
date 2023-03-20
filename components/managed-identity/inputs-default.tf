locals {
  // TODO delete after applying MI in all ENVs
  // working around 'Error: Provider configuration not present'
  acr = {
    # ss = {
    #   subscription = "5ca62022-6aa2-4cee-aaa7-e7536c8d566c"
    #   project      = "sds"
    # }
  }

  log_analytics_env_mapping = {
    sandbox = ["sbox", "ptlsbox"]
    nonprod = ["dev", "perftest", "ithc", "demo", "aat", "preview"]
    prod    = ["prod", "mgmt", "ptl"]
  }

  log_analytics_workspace = {
    sandbox = {
      subscription_id = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
      name            = "hmcts-sandbox"
    }
    nonprod = {
      subscription_id = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
      name            = "hmcts-nonprod"
    }
    prod = {
      subscription_id = "8999dec3-0104-4a27-94ee-6588559729d1"
      name            = "hmcts-prod"
    }
  }
  log_analytics_subscription_id = local.log_analytics_workspace[[for x in keys(local.log_analytics_env_mapping) : x if contains(local.log_analytics_env_mapping[x], var.env)][0]].subscription_id
  resolved_name                 = local.log_analytics_workspace[[for x in keys(local.log_analytics_env_mapping) : x if contains(local.log_analytics_env_mapping[x], var.env)][0]].name

}

variable "location" {
  default = "UK South"
}

variable "builtFrom" {
  default = "hmcts/aks-cft-deploy"
}

variable "product" {
  default = "cft-platform"
}

variable "application_name" {
  default = "flux"
}

variable "expiresAfter" {
  default = "3000-01-01"
}

variable "service_operator_settings_enabled" {
  default = false
}
