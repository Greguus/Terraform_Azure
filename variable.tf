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

variable "postgresql_subnet_address_space" {
  description = "Delegated subnet for azure postgresql flexible server"
  default     = ["10.10.0.192/26"]
}
variable "subnet01_name" {
  description = "Name for the subnet01"
  default     = "gregsec_dev_subnet01"
}

variable "postgresql_subnet_name" {
  description = "Name for the postresql flexible server subnet"
  default     = "postgresql_subnet"
}

variable "postgresql_server_dns_zone_name" {
  description = "Name for the private dns zone"
  default     = "gregsec.dev.postgres.database.azure.com"  
}

variable "dns_link_name" {
  description = "Name for the dns virtual network link"
  default     = "dns_to_vnet_link"
}

variable "postgresql_for_django_name" {
  description = "Postgresql database for django app"
  default     = "django-postgresql-server"
}

