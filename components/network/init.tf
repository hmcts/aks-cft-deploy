terraform {
  required_version = ">= 0.12.0"

  backend "azurerm" {
    subscription_id = "04d27a32-7a07-48b3-95b8-3c8691e1a263"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.58.0"
    }
  }
}

variable "subscription_id" {}

provider "azurerm" {
  features {}
  subscription_id            = var.subscription_id
  skip_provider_registration = "true"
}

provider "azurerm" {
  alias                      = "hmcts-control"
  skip_provider_registration = "true"
  features {}
  subscription_id = "04d27a32-7a07-48b3-95b8-3c8691e1a263"
}

provider "azurerm" {
  subscription_id            = local.hub[var.hub].subscription
  skip_provider_registration = "true"
  features {}
  alias = "hub"
}

provider "azurerm" {
  subscription_id            = local.hub["sbox"].subscription
  skip_provider_registration = "true"
  features {}
  alias = "hub-sbox"
}

provider "azurerm" {
  subscription_id            = local.hub["nonprod"].subscription
  skip_provider_registration = "true"
  features {}
  alias = "hub-nonprod"
}

provider "azurerm" {
  subscription_id            = local.hub["prod"].subscription
  skip_provider_registration = "true"
  features {}
  alias = "hub-prod"
}

provider "azurerm" {
  subscription_id            = var.private_dns_subscription
  skip_provider_registration = "true"
  features {}
  alias = "private-dns"
}

provider "azurerm" {
  subscription_id            = "1baf5470-1c3e-40d3-a6f7-74bfbce4b348"
  skip_provider_registration = "true"
  features {}
  alias = "private-dns-private-endpoint"
}

provider "azurerm" {
  subscription_id            = "ed302caf-ec27-4c64-a05e-85731c3ce90e"
  skip_provider_registration = "true"
  features {}
  alias = "vpn"
}

provider "azurerm" {
  subscription_id            = local.core-infra-routetable[var.environment].subscription
  skip_provider_registration = "true"
  features {}
  alias = "core-infra-routetable"
}

locals {
  core-infra-routetable = {
    sbox = {
      subscription = "bf308a5c-0624-4334-8ff8-8dca9fd43783"
    }
    ithc = {
      subscription = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
    }
    perftest = {
      subscription = "7a4e3bd5-ae3a-4d0c-b441-2188fee3ff1c"
    }
    ptlsbox = {
      subscription = "1497c3d7-ab6d-4bb7-8a10-b51d03189ee3"
    }
    preview = {
      subscription = "1c4f0704-a29e-403d-b719-b90c34ef14c9"
    }
  }

  environment = var.environment == "sbox" ? "sandbox" : var.environment == "test" ? "perftest" : "${var.environment}"
}