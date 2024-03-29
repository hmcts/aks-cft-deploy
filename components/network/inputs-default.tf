locals {
  hub = {
    nonprod = {
      subscription = "fb084706-583f-4c9a-bdab-949aac66ba5c"
      ukSouth = {
        name         = "hmcts-hub-nonprodi"
        peering_name = "hubUkSnonprod"
        next_hop_ip  = "10.11.72.36"
      }
    }
    sbox = {
      subscription = "ea3a8c1e-af9d-4108-bc86-a7e2d267f49c"
      ukSouth = {
        name         = "hmcts-hub-sbox-int"
        peering_name = "hubUkS"
        next_hop_ip  = "10.10.200.36"
      }
    }
    prod = {
      subscription = "0978315c-75fe-4ada-9d11-1eb5e0e0b214"
      ukSouth = {
        name         = "hmcts-hub-prod-int"
        peering_name = "hubUkS"
        next_hop_ip  = "10.11.8.36"
      }
    }
  }

  hub_to_env_mapping = {
    sbox    = ["sbox", "ptlsbox"]
    nonprod = ["demo", "dev", "aat", "perftest", "ithc", "ptl", "preview"]
    prod    = ["prod", "aat", "ptl"]
  }
}

variable "location" {
  default = "uksouth"
}

variable "service_shortname" {
  default = "aks"
}

variable "private_endpoint_private_dns_zones" {
  default = [
    "privatelink.database.windows.net",
    "privatelink.blob.core.windows.net",
    "privatelink.vaultcore.azure.net",
    "privatelink.datafactory.azure.net",
    "privatelink.postgres.database.azure.com",
    "privatelink.servicebus.windows.net",
    "privatelink.redis.cache.windows.net",
    "private.postgres.database.azure.com",
    "platform.hmcts.net", # added as all envs require this currently
    "reform.hmcts.net"    # added as all envs require this currently
  ]
}

variable "additional_routes" {
  default = []
}

variable "additional_subnets" {
  default = []
}

variable "builtFrom" {
  default = "hmcts/aks-cft-deploy"
}

variable "product" {
  default = "cft-platform"
}

variable "additional_routes_application_gateway" {
  default = []
}

variable "routes" {
  default = []
}

variable "additional_routes_coreinfra" {
  default = []
}

variable "coreinfra_subnets" {
  default = []
}

variable "expiresAfter" {
  default = "3000-01-01"
}
