provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "gregsec_dev_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  depends_on = [ azurerm_resource_group.gregsec_dev_rg ]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet01_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet01_address_space

  depends_on = [ azurerm_virtual_network.vnet ]
}
