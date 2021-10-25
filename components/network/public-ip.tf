resource "azurerm_public_ip" "demo_public_ip" {
  count = contains(["demo"], var.environment) ? [] : [
    {
      name                = cft-aks-demo-pip-00
      location            = var.location
      resource_group_name = "core-infra-${local.environment}"
      allocation_method   = "Static"

      tags = module.ctags.common_tags
    },
    {
      name                = cft-aks-demo-pip-01
      location            = var.location
      resource_group_name = "core-infra-${local.environment}"
      allocation_method   = "Static"

      tags = module.ctags.common_tags
    }
  ]
}