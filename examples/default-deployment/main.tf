terraform {
  # https://github.com/hashicorp/terraform/tags
  required_version = "~> 1.3.0"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  tags = {
    CreatedBy  = "Terratest"
    ModuleName = "teras-terratest-example"
  }
}

resource "azurerm_resource_group" "terratest" {
  name     = var.resource_group_name
  location = var.location

  tags = local.tags
}

module "data_lake" {
  source = "../.."

  location            = azurerm_resource_group.terratest.location
  resource_group_name = azurerm_resource_group.terratest.name
  resource_suffix     = var.resource_suffix

  tags = local.tags
}
