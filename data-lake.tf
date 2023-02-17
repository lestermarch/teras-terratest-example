resource "random_string" "unique" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_storage_account" "data_lake" {
  #checkov:skip=CKV_AZURE_59:  Firewall is enabled with azurerm_storage_account_network_rules
  #checkov:skip=CKV_AZURE_190: Firewall is enabled with azurerm_storage_account_network_rules
  #checkov:skip=CKV_AZURE_206: Replication type is specified through module variables
  #checkov:skip=CKV2_AZURE_1:  [TODO] Option for customer-managed keys
  #checkov:skip=CKV2_AZURE_18: [TODO] Option for customer-managed keys
  name                            = replace("st-${var.resource_suffix}-${random_string.unique.id}", "-", "")
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.data_lake_account_tier
  account_replication_type        = "GRS"
  account_kind                    = local.data_lake_account_kind
  default_to_oauth_authentication = true
  enable_https_traffic_only       = true
  is_hns_enabled                  = true
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = true

  blob_properties {
    delete_retention_policy {
      days = var.data_lake_retention_days
    }

    container_delete_retention_policy {
      days = var.data_lake_retention_days
    }
  }

  queue_properties {
    logging {
      read                  = true
      write                 = true
      delete                = true
      retention_policy_days = var.data_lake_retention_days
      version               = "1.0"
    }

    minute_metrics {
      enabled               = true
      include_apis          = true
      retention_policy_days = var.data_lake_retention_days
      version               = "1.0"
    }

    hour_metrics {
      enabled               = true
      include_apis          = true
      retention_policy_days = var.data_lake_retention_days
      version               = "1.0"
    }
  }

  tags = local.tags
}

resource "azurerm_storage_data_lake_gen2_filesystem" "data_lake" {
  name               = "adls"
  storage_account_id = azurerm_storage_account.data_lake.id
}

resource "azurerm_storage_container" "data_lake" {
  #checkov:skip=CKV2_AZURE_21: [TODO] Storage container logging
  for_each = toset(var.data_lake_storage_containers)

  name                  = each.key
  storage_account_name  = azurerm_storage_account.data_lake.name
  container_access_type = "private"

  depends_on = [
    azurerm_storage_data_lake_gen2_filesystem.data_lake
  ]
}
