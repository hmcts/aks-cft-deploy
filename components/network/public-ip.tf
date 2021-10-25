resource "azurerm_public_ip" "cft-aks-demo-pip" {
  count = contains(["demo"], var.environment) ? 2 : 0
  name  = azurerm_public_ip.name-[count.index]

  location            = var.location
  resource_group_name = "core-infra-${local.environment}"
  allocation_method   = "Static"

  tags = module.ctags.common_tags
}