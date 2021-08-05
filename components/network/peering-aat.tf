// AAT specific for Preview
provider "azurerm" {
  subscription_id            = local.hub["nonprod"].subscription
  skip_provider_registration = "true"
  features {}
  alias = "hubnonprod"
}

data "azurerm_virtual_network" "hub-south-vnet-nonprod" {
  provider            = azurerm.hubnonprod
  name                = local.hub["nonprod"].ukSouth.name
  resource_group_name = local.hub["nonprod"].ukSouth.name
}

resource "azurerm_virtual_network_peering" "hubnonprod-south-to-spoke" {
  count    = var.environment == "aat" ? 1 : 0
  provider = azurerm.hub

  name = format("%s%s",
    var.project,
    var.environment
  )

  resource_group_name          = local.hub["nonprod"].ukSouth.name
  virtual_network_name         = local.hub["nonprod"].ukSouth.name
  remote_virtual_network_id    = module.network.network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}

resource "azurerm_virtual_network_peering" "spoke-to-hubnonprod-south" {
  count                        = var.environment == "aat" ? 1 : 0
  name                         = "hubUkS"
  resource_group_name          = module.network.network_resource_group
  virtual_network_name         = module.network.network_name
  remote_virtual_network_id    = data.azurerm_virtual_network.hub-south-vnet-nonprod.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
}



