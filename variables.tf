variable "data_lake_account_tier" {
  default     = "Standard"
  description = "The tier of the ADLS Storage Account"
  type        = string
}

variable "data_lake_retention_days" {
  default     = 7
  description = "The number of days blob and queue data will be retained for upon deletion"
  type        = number
}

variable "data_lake_storage_containers" {
  default     = ["bronze", "silver", "gold"]
  description = "A list of container names to be created in the ADLS Storage Account"
  type        = list(string)
}

variable "location" {
  default     = "uksouth"
  description = "The Azure region into which resources will be deployed"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group into which resources should be deployed"
  type        = string
}

variable "resource_suffix" {
  description = "The resource suffix to append to resources"
  type        = string

  validation {
    condition     = can(regex("^[a-z]+(-[a-z]+)*$", var.resource_suffix))
    error_message = "Resource names should use only lowercase characters, numbers, and hyphens."
  }
}

variable "tags" {
  default     = {}
  description = "A collection of tags to assign to taggable resources"
  type        = map(string)
}
