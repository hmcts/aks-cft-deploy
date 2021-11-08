resource "azurerm_resource_group" "kubernetes_resource_group" {
  count    = var.cluster_count
  location = var.location

  name = format("%s-%s-%s-rg",
    var.project,
    var.environment,
    "0${count.index}"
  )
  tags = module.ctags.common_tags
}

resource "azurerm_resource_group" "disks_resource_group" {
  location = var.location
  name     = "disks-${var.environment}-rg"
  tags     = module.ctags.common_tags
}

module "loganalytics" {
  source      = "git::https://github.com/hmcts/terraform-module-log-analytics-workspace-id.git?ref=master"
  environment = var.environment
}

module "kubernetes" {
  count  = var.cluster_count
  source = "git::https://github.com/hmcts/aks-module-kubernetes.git?ref=master"

  control_resource_group = "azure-control-${local.control_resource_environment}-rg"
  environment            = var.environment
  location               = var.location

  sku_tier = var.sku_tier
  providers = {
    azurerm               = azurerm
    azurerm.hmcts-control = azurerm.hmcts-control
    azurerm.acr           = azurerm.acr
    azurerm.global_acr    = azurerm.global_acr
  }


  resource_group_name = azurerm_resource_group.kubernetes_resource_group[count.index].name

  network_name                = local.network_name
  network_shortname           = local.network_shortname
  network_resource_group_name = local.network_resource_group_name

  cluster_number    = "0${count.index}"
  service_shortname = var.service_shortname
  project           = var.project

  log_workspace_id           = module.loganalytics.workspace_id
  monitor_diagnostic_setting = var.monitor_diagnostic_setting

  control_vault = var.control_vault

  ptl_cluster = var.ptl_cluster

  kubernetes_cluster_ssh_key = var.kubernetes_cluster_ssh_key

  kubernetes_cluster_agent_min_count = lookup(var.system_node_pool, "min_nodes", 2)
  kubernetes_cluster_agent_max_count = lookup(var.system_node_pool, "max_nodes", 3)
  kubernetes_cluster_agent_vm_size   = lookup(var.system_node_pool, "vm_size", "Standard_DS3_v2")
  kubernetes_cluster_version         = var.kubernetes_cluster_version
  kubernetes_cluster_agent_max_pods  = var.kubernetes_cluster_agent_max_pods

  tags = module.ctags.common_tags

  enable_user_system_nodepool_split = var.enable_user_system_nodepool_split == true ? true : false

  additional_node_pools = contains(["ptlsbox", "ptl", "perftest", "ithc", "aat"], var.environment) ? [] : [
    {
      name                = "linux"
      vm_size             = lookup(var.linux_node_pool, "vm_size", "Standard_DS3_v2")
      min_count           = lookup(var.linux_node_pool, "min_nodes", 2)
      max_count           = lookup(var.linux_node_pool, "max_nodes", 4)
      os_type             = "Linux"
      node_taints         = []
      enable_auto_scaling = true
      mode                = "User"
    }
  ]

  project_acr_enabled = var.project_acr_enabled
  availability_zones  = var.availability_zones
  depends_on          = [azurerm_resource_group.disks_resource_group]
}

module "ctags" {
  source      = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment = var.environment
  product     = var.product
  builtFrom   = var.builtFrom
}
