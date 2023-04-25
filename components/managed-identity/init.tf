terraform {
  required_version = ">= 1.0.10"

  backend "azurerm" {
    subscription_id = "04d27a32-7a07-48b3-95b8-3c8691e1a263"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.35.0"
    }
  }
}
locals {
  # MIs for managed-identities-sandbox-rg etc - they are RPE MIs
  mi_cft = {
    sbox = {
      subscription = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
    }
    perftest = {
      subscription = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
    }
    aat = {
      subscription = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
    ithc = {
      subscription = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
    }
    ptlsbox = {
      subscription = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
    }
    preview = {
      subscription = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
    ptl = {
      subscription = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
    }
    prod = {
      subscription = "8999dec3-0104-4a27-94ee-6588559729d1"
    }
    demo = {
      subscription = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
  }
}

provider "azurerm" {
  subscription_id            = local.mi_cft[var.env].subscription
  skip_provider_registration = "true"
  features {}
  alias = "acr"
}

variable "subscription_id" {}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "azurerm" {
  alias                      = "hmcts-control"
  skip_provider_registration = "true"
  features {}
  subscription_id = "04d27a32-7a07-48b3-95b8-3c8691e1a263"
}

// TODO delete after applying MI in all ENVs
// working around 'Error: Provider configuration not present'
provider "azurerm" {
  subscription_id            = local.acr[var.project].subscription
  skip_provider_registration = "true"
  features {}
  alias = "acr"
}

provider "azurerm" {
  subscription_id            = local.log_analytics_subscription_id
  skip_provider_registration = "true"
  features {}
  alias = "log_analytics"
}
