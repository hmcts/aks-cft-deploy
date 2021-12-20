data "azurerm_resources" "demo_nsg" {
  count = var.cluster_count
  resource_group_name = format("%s-%s-%s-aks-node-rg",
    var.project,
    var.environment,
    "0${count.index}"
  )
  type = "Microsoft.Network/networkSecurityGroups"
}
resource "azurerm_network_security_rule" "AllowInternetToOAuthProxy" {
  count                       = contains(["demo"], var.environment) ? 1 : 0
  name                        = "AllowInternetToOAuthProxy"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80, 443"
  source_address_prefix       = "*"
  destination_address_prefix  = "51.11.25.221, 20.68.184.102"
  resource_group_name         = data.azurerm_resources.demo_nsg[count.index].resource_group_name
  network_security_group_name = data.azurerm_resources.demo_nsg[count.index].resources.0.name
}

resource "azurerm_network_security_rule" "TraefikNoProxy" {
  count                       = contains(["demo"], var.environment) ? 1 : 0
  name                        = "TraefikNoProxy"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "51.11.5.163, 20.68.186.154"
  resource_group_name         = data.azurerm_resources.demo_nsg[count.index].resource_group_name
  network_security_group_name = data.azurerm_resources.demo_nsg[count.index].resources.0.name
}