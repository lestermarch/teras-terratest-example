locals {
  # Premum ADLS Storage Accounts should use the Block Blob account type
  data_lake_account_kind = var.data_lake_account_tier == "Premium" ? "BlockBlobStorage" : "StorageV2"

  # Merge resource group tags, input tags, and module-specific tags
  tags = merge(
    var.tags,
    {
      ModuleName = "synapse-data-lake"
    }
  )
}
