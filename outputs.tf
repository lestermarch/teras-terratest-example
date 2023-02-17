output "data_lake_account_name" {
  description = "The name of the ADLS Storage Account"
  value       = azurerm_storage_account.data_lake.name
}

output "data_lake_adls_filesystem_id" {
  description = "The hierarchical filesystem ID of the ADLS Storage Account"
  value       = azurerm_storage_data_lake_gen2_filesystem.data_lake.id
}

output "data_lake_resource_group_name" {
  description = "The name of the resource group into which the ADLS Storage Account is deployed"
  value       = azurerm_storage_account.data_lake.resource_group_name
}
