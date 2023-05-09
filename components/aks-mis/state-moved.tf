moved {
  from = azurerm_role_assignment.uami_cft_rg_identity_operator[0]
  to   = azurerm_role_assignment.uami_cft_rg_identity_operator["00"]
}
moved {
  from = azurerm_role_assignment.uami_cft_rg_identity_operator[1]
  to   = azurerm_role_assignment.uami_cft_rg_identity_operator["01"]
}
moved {
  from = azurerm_role_assignment.preview1aat_cft_rg_identity_operator[1]
  to   = azurerm_role_assignment.preview1aat_cft_rg_identity_operator["01"]
}
moved {
  from = azurerm_role_assignment.preview2aat_cft_rg_identity_operator[1]
  to   = azurerm_role_assignment.preview2aat_cft_rg_identity_operator["01"] 
}