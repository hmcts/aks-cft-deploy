locals {
  hub = {
    nonprod = {
      subscription = "fb084706-583f-4c9a-bdab-949aac66ba5c"
      ukSouth = {
        name         = "hmcts-hub-nonprodi"
        peering_name = "hubUkSnonprod"
        next_hop_ip  = "10.11.72.36"
      }
      ukWest = {
        name         = "ukw-hub-nonprodi"
        peering_name = "hubUkWnonprod"
        next_hop_ip  = "10.49.72.36"
      }
    }
    sbox = {
      subscription = "ea3a8c1e-af9d-4108-bc86-a7e2d267f49c"
      ukSouth = {
        name         = "hmcts-hub-sbox-int"
        peering_name = "hubUkS"
        next_hop_ip  = "10.10.200.36"
      }
      ukWest = {
        name         = "ukw-hub-sbox-int"
        peering_name = "hubUkW"
        next_hop_ip  = "10.48.200.36"
      }
    }
    prod = {
      subscription = "0978315c-75fe-4ada-9d11-1eb5e0e0b214"
      ukSouth = {
        name         = "hmcts-hub-prod-int"
        peering_name = "hubUkS"
        next_hop_ip  = "10.11.8.36"
      }
      ukWest = {
        name         = "ukw-hub-prod-int"
        peering_name = "hubUkW"
        next_hop_ip  = "10.49.8.36"
      }
    }
  }

  hub_to_env_mapping = {
    sbox    = ["sbox", "ptlsbox"]
    nonprod = ["demo", "dev", "aat", "perftest", "ithc", "ptl"]
    prod    = ["prod", "aat", "ptl"]
  }

  regions = [
    "ukSouth",
    "ukWest"
  ]


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

variable "additional_routes_appgw" {
  default = []
}

variable "route_name" {
  default = "default"
}

variable "route_address_prefix" {
  default = "0.0.0.0/0"
}

variable "route_next_hop_type" {
  default = "VirtualAppliance"
}

variable "route_next_hop_in_ip_address" {
  default = "10.10.1.1"
}