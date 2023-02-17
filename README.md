# Teras Module
Lorem ipsum...

## Table of Contents
1. [Architecture](#architecture)
2. [Usage](#usage)
3. [Requirements](#requirements)
4. [Providers](#providers)
5. [Inputs](#inputs)
6. [Outputs](#outputs)

## Architecture
The below diagram provides an overview of the resources deployed in this module:

<img src="docs/architecture.svg">

## Usage
Example minimal deployment using module defaults:
```
module "teras_module" {
  source  = "..."
  version = "..."

  variable_a = "..."
  varialbe_b = "..."
}
```

| :scroll: Note: Defaults |
|----------|
| See [inputs](#inputs) for a complete list of input variables and their defaults. |

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.44.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_storage_account.data_lake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.data_lake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_data_lake_gen2_filesystem.data_lake](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem) | resource |
| [random_string.unique](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_lake_account_tier"></a> [data\_lake\_account\_tier](#input\_data\_lake\_account\_tier) | The tier of the ADLS Storage Account | `string` | `"Standard"` | no |
| <a name="input_data_lake_retention_days"></a> [data\_lake\_retention\_days](#input\_data\_lake\_retention\_days) | The number of days blob and queue data will be retained for upon deletion | `number` | `7` | no |
| <a name="input_data_lake_storage_containers"></a> [data\_lake\_storage\_containers](#input\_data\_lake\_storage\_containers) | A list of container names to be created in the ADLS Storage Account | `list(string)` | <pre>[<br>  "bronze",<br>  "silver",<br>  "gold"<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | The Azure region into which resources will be deployed | `string` | `"uksouth"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group into which resources should be deployed | `string` | n/a | yes |
| <a name="input_resource_suffix"></a> [resource\_suffix](#input\_resource\_suffix) | The resource suffix to append to resources | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A collection of tags to assign to taggable resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_data_lake_account_name"></a> [data\_lake\_account\_name](#output\_data\_lake\_account\_name) | The name of the ADLS Storage Account |
| <a name="output_data_lake_adls_filesystem_id"></a> [data\_lake\_adls\_filesystem\_id](#output\_data\_lake\_adls\_filesystem\_id) | The hierarchical filesystem ID of the ADLS Storage Account |
| <a name="output_data_lake_resource_group_name"></a> [data\_lake\_resource\_group\_name](#output\_data\_lake\_resource\_group\_name) | The name of the resource group into which the ADLS Storage Account is deployed |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
