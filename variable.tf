variable "resource_group_name" {
  type = string
  default = "gregsec_dev_rg"
  description = "Name of the resource group"
}

variable "subscription_name" {
  type = string
  default = "SecureITall"
  description = "Name of the subscription"
}

variable "location" {
  type = string
  default = "australiaeast"
  description = "Location of the resources"
}

variable "vnet_address_space" {
  description = "The address space to be used for the Azure virtual network."
  default     = ["10.10.0.0/22"]
}

variable "vnet_name" {
  description = "Name of the VNET"
  default     = "gregsec_dev_vnet"
  
}

variable "subnet01_address_space" {
  description = "The address space to be used for the Azure subnet01."
  default     = ["10.10.0.0/26"]
}

variable "subnet01_name" {
  description = "Name for the subnet01"
  default = "gregsec_dev_subnet01"
}

