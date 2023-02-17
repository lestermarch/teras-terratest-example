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
