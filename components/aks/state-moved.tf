moved {
    from = module.kubernetes[1].azurerm_kubernetes_cluster.kubernetes_cluster 
    to   = module.kubernetes["01"].azurerm_kubernetes_cluster.kubernetes_cluster
}
moved {
    from = module.kubernetes[0].azurerm_kubernetes_cluster.kubernetes_cluster 
    to   = module.kubernetes["00"].azurerm_kubernetes_cluster.kubernetes_cluster
}
moved {
    from = azurerm_resource_group.kubernetes_resource_group[0] 
    to   = azurerm_resource_group.kubernetes_resource_group["00"]
}
moved {
    from = azurerm_resource_group.kubernetes_resource_group[1] 
    to   = azurerm_resource_group.kubernetes_resource_group["01"]
}
moved {
    from = module.kubernetes[0].azapi_resource.service_operator_credential[0]
    to   = module.kubernetes["00"].azapi_resource.service_operator_credential[0]
}
moved {
    from = module.kubernetes[0].azurerm_kubernetes_cluster_node_pool.additional_node_pools["linux"]
    to   = module.kubernetes["00"].azurerm_kubernetes_cluster_node_pool.additional_node_pools["linux"]
}
moved {
    from = module.kubernetes[1].azurerm_kubernetes_cluster_node_pool.additional_node_pools["linux"]
    to   = module.kubernetes["01"].azurerm_kubernetes_cluster_node_pool.additional_node_pools["linux"]
}
moved {
    from = module.kubernetes[0].azurerm_monitor_diagnostic_setting.kubernetes_cluster_diagnostic_setting[0]
    to   = module.kubernetes["00"].azurerm_monitor_diagnostic_setting.kubernetes_cluster_diagnostic_setting[0]
}
moved {
    from = module.kubernetes[1].azurerm_monitor_diagnostic_setting.kubernetes_cluster_diagnostic_setting[0]
    to   = module.kubernetes["01"].azurerm_monitor_diagnostic_setting.kubernetes_cluster_diagnostic_setting[0]
}
moved {
    from = module.kubernetes[0].azurerm_role_assignment.aks_auto_shutdown[0]
    to   = module.kubernetes["00"].azurerm_role_assignment.aks_auto_shutdown[0]
}
moved {
    from = module.kubernetes[1].azurerm_role_assignment.aks_auto_shutdown[0]
    to   = module.kubernetes["01"].azurerm_role_assignment.aks_auto_shutdown[0]
}
moved {
    from = module.kubernetes[0].azurerm_role_assignment.genesis_managed_identity_operator[0]
    to   = module.kubernetes["00"].azurerm_role_assignment.genesis_managed_identity_operator[0]
}
moved {
    from = module.kubernetes[1].azurerm_role_assignment.genesis_managed_identity_operator[0]
    to   = module.kubernetes["01"].azurerm_role_assignment.genesis_managed_identity_operator[0]
}
moved {
    from = module.kubernetes[0].azurerm_role_assignment.global_registry_acrpull[0] 
    to   = module.kubernetes["00"].azurerm_role_assignment.global_registry_acrpull[0]
}
moved {
    from = module.kubernetes[1].azurerm_role_assignment.global_registry_acrpull[0] 
    to   = module.kubernetes["01"].azurerm_role_assignment.global_registry_acrpull[0]
}
moved {
    from = module.kubernetes[0].azurerm_role_assignment.node_infrastructure_update_scale_set
    to   = module.kubernetes["00"].azurerm_role_assignment.node_infrastructure_update_scale_set
}
moved {
    from = module.kubernetes[1].azurerm_role_assignment.node_infrastructure_update_scale_set
    to   = module.kubernetes["01"].azurerm_role_assignment.node_infrastructure_update_scale_set
}
moved {
    from = module.kubernetes[0].azurerm_role_assignment.project_acrpull[0]
    to   = module.kubernetes["00"].azurerm_role_assignment.project_acrpull[0]
}
moved {
    from = module.kubernetes[1].azurerm_role_assignment.project_acrpull[0]
    to   = module.kubernetes["01"].azurerm_role_assignment.project_acrpull[0]
}
moved {
    from = module.kubernetes[0].azurerm_role_assignment.uami_rg_identity_operator[0]
    to   = module.kubernetes["00"].azurerm_role_assignment.uami_rg_identity_operator[0]
}
moved {
    from = module.kubernetes[1].azurerm_role_assignment.uami_rg_identity_operator[0]
    to   = module.kubernetes["01"].azurerm_role_assignment.uami_rg_identity_operator[0]
}
moved {
    from = module.kubernetes[0].azurerm_role_assignment.update_checker[0]
    to   = module.kubernetes["00"].azurerm_role_assignment.update_checker[0]
}
moved {
    from = module.kubernetes[1].azurerm_role_assignment.update_checker[0]
    to   = module.kubernetes["01"].azurerm_role_assignment.update_checker[0]
}
moved {
    from = module.kubernetes[1].azapi_resource.service_operator_credential[0]
    to   = module.kubernetes["01"].azapi_resource.service_operator_credential[0]
}