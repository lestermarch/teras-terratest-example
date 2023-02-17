output "data_lake_account_name" {
  description = "The name of the ADLS Storage Account"
  value       = module.data_lake.data_lake_account_name
}

output "data_lake_resource_group_name" {
  description = "The name of the resource group into which the ADLS Storage Account is deployed"
  value       = module.data_lake.data_lake_resource_group_name
}
