resource "azurerm_public_ip" "demo_public_ip" {
  count = contains(["demo"], var.environment) ? 2 : 0
  name  = element(cft-aks-demo-pip-, [count.index])

  location            = var.location
  resource_group_name = "core-infra-${local.environment}"
  allocation_method   = "Static"

  tags = module.ctags.common_tags
}