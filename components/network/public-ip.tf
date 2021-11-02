resource "azurerm_public_ip" "demo_public_ip_01" {
  count = contains(["demo"], var.environment) ? 1 : 0
  name = format("cft-aks-%s-pip-01",
    var.environment
  )

  location            = var.location
  resource_group_name = "core-infra-${local.environment}"
  allocation_method   = "Static"

  tags = module.ctags.common_tags
}

resource "azurerm_public_ip" "demo_public_ip_02" {
  count = contains(["demo"], var.environment) ? 1 : 0
  name = format("cft-aks-%s-pip-02",
    var.environment
  )

  location            = var.location
  resource_group_name = "core-infra-${local.environment}"
  allocation_method   = "Static"

  tags = module.ctags.common_tags
}

resource "azurerm_public_ip" "demo_public_ip_03" {
  count = contains(["demo"], var.environment) ? 1 : 0
  name = format("cft-aks-%s-pip-02",
    var.environment
  )

  location            = var.location
  resource_group_name = "core-infra-${local.environment}"
  allocation_method   = "Static"

  tags = module.ctags.common_tags
}

resource "azurerm_public_ip" "demo_public_ip_04" {
  count = contains(["demo"], var.environment) ? 1 : 0
  name = format("cft-aks-%s-pip-02",
    var.environment
  )

  location            = var.location
  resource_group_name = "core-infra-${local.environment}"
  allocation_method   = "Static"

  tags = module.ctags.common_tags
}
