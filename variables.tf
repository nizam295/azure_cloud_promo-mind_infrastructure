# File: variables.tf

variable "location" {
  type        = string
  default     = "Central India"
  description = "Target Azure Data Center location"
}

variable "resource_group_name" {
  type        = string
  default     = "PromoMind-Production-RG"
  description = "The core logical folder grouping your Azure assets"
}

variable "vnet_address_space" {
  type        = list(string)
  default     = ["10.0.0.0/16"]
  description = "Primary IP boundary space for the Virtual Network"
}
