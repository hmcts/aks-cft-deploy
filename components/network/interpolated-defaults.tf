data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

locals {

  environment = (var.environment == "perftest") ? "test" : "${var.environment}"

  network_resource_group_name = format("%s-%s-network-rg",
    var.project,
    local.environment
  )
  network_shortname = format("%s_%s",
    var.project,
    var.service_shortname
  )
}



