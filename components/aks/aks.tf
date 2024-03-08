resource "azurerm_resource_group" "kubernetes_resource_group" {
  for_each = toset([for key, value in var.clusters : key])
  location = var.location

  name = format("%s-%s-%s-rg",
    var.project,
    var.env,
    each.value
  )
  tags = module.ctags.common_tags
}

module "loganalytics" {
  source      = "git::https://github.com/hmcts/terraform-module-log-analytics-workspace-id.git?ref=master"
  environment = var.env
}

data "azuread_service_principal" "version_checker" {
  display_name = "DTS CFT AKS version checker"
}

data "azuread_service_principal" "aks_auto_shutdown" {
  display_name = "DTS AKS Auto-Shutdown"
}

module "kubernetes" {
  for_each = toset([for key, value in var.clusters : key])
  source   = "git::https://github.com/hmcts/aks-module-kubernetes.git?ref=master"

  control_resource_group = "azure-control-${local.control_resource_environment}-rg"
  environment            = var.env
  location               = var.location

  oms_agent_enabled  = var.oms_agent_enabled
  csi_driver_enabled = var.csi_driver_enabled

  sku_tier = var.sku_tier
  providers = {
    azurerm               = azurerm
    azurerm.hmcts-control = azurerm.hmcts-control
    azurerm.acr           = azurerm.acr
    azurerm.global_acr    = azurerm.global_acr
  }

  resource_group_name = azurerm_resource_group.kubernetes_resource_group[each.value].name

  network_name                = local.network_name
  network_shortname           = local.network_shortname
  network_resource_group_name = local.network_resource_group_name

  cluster_number    = each.value
  service_shortname = var.service_shortname
  project           = var.project

  log_workspace_id                   = module.loganalytics.workspace_id
  monitor_diagnostic_setting         = var.monitor_diagnostic_setting
  monitor_diagnostic_setting_metrics = var.monitor_diagnostic_setting_metrics
  kube_audit_admin_logs_enabled      = var.kube_audit_admin_logs_enabled

  control_vault = var.control_vault

  ptl_cluster = var.ptl_cluster

  kubernetes_cluster_ssh_key = var.kubernetes_cluster_ssh_key

  kubernetes_cluster_agent_min_count = lookup(var.system_node_pool, "min_nodes", 2)
  kubernetes_cluster_agent_max_count = lookup(var.system_node_pool, "max_nodes", 3)
  kubernetes_cluster_agent_vm_size   = lookup(var.system_node_pool, "vm_size", "Standard_DS3_v2")
  kubernetes_cluster_version         = var.clusters[each.value]["kubernetes_cluster_version"]
  kubernetes_cluster_agent_max_pods  = var.kubernetes_cluster_agent_max_pods

  tags = module.ctags.common_tags

  enable_user_system_nodepool_split = var.enable_user_system_nodepool_split == true ? true : false

  additional_node_pools = contains([], var.env) ? tuple([]) : [
    {
      name                = "linux"
      vm_size             = lookup(var.linux_node_pool, "vm_size", "Standard_DS3_v2")
      min_count           = lookup(var.linux_node_pool, "min_nodes", 2)
      max_count           = lookup(var.linux_node_pool, "max_nodes", 4)
      max_pods            = lookup(var.linux_node_pool, "max_pods", 30)
      os_type             = "Linux"
      node_taints         = []
      enable_auto_scaling = true
      mode                = "User"
    },
    {
      name                = "cronjob"
      vm_size             = "Standard_D4ds_v5"
      min_count           = 0
      max_count           = 10
      max_pods            = 30
      os_type             = "Linux"
      node_taints         = ["dedicated=jobs:NoSchedule"]
      enable_auto_scaling = true
      mode                = "User"
    },
    {
      name                = "spotinstance"
      vm_size             = lookup(var.spot_node_pool, "vm_size", "Standard_D4ds_v5")
      min_count           = lookup(var.spot_node_pool, "min_nodes", 0)
      max_count           = lookup(var.spot_node_pool, "max_nodes", 5)
      max_pods            = lookup(var.spot_node_pool, "max_pods", 30)
      os_type             = "Linux"
      node_taints         = ["kubernetes.azure.com/scalesetpriority=spot:NoSchedule"]
      enable_auto_scaling = true
      mode                = "User"
      priority            = "Spot"
      spot_max_price      = "-1"

    }
  ]

  project_acr_enabled = var.project_acr_enabled
  availability_zones  = var.availability_zones

  enable_automatic_channel_upgrade_patch = var.enable_automatic_channel_upgrade_patch

  enable_node_os_channel_upgrade_nodeimage = contains(["sbox"], var.env) ? true : false

  aks_version_checker_principal_id = data.azuread_service_principal.version_checker.object_id
  aks_role_definition              = "Contributor"
  aks_auto_shutdown_principal_id   = data.azuread_service_principal.aks_auto_shutdown.object_id
}

module "ctags" {
  source       = "git::https://github.com/hmcts/terraform-module-common-tags.git?ref=master"
  environment  = var.env
  product      = var.product
  builtFrom    = var.builtFrom
  expiresAfter = var.expiresAfter
  autoShutdown = var.autoShutdown
  startupMode  = var.startupMode
}