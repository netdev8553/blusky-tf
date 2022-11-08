output "container_name" {
  value = azurerm_storage_container.tf-state.name
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_acct_name" {
  value = azurerm_storage_account.sa.name
}

output "region" {
  value = azurerm_resource_group.rg.location
}
