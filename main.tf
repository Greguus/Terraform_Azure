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

resource "azurerm_subnet" "subnet01" {
  name                 = var.subnet01_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet01_address_space

  depends_on = [ azurerm_virtual_network.vnet ]
}

resource "azurerm_subnet" "postgresql_subnet" {
  name                 = var.postgresql_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.postgresql_subnet_address_space
  delegation {
    name = "delegation_postgresql_subnet"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }

  depends_on = [ azurerm_resource_group.gregsec_dev_rg,
                azurerm_virtual_network.vnet,
                ]
}

resource "azurerm_private_dns_zone" "gregsec_dev_dns" {
  name                = var.dns_zone_name
  resource_group_name = var.resource_group_name 

  depends_on = [ azurerm_resource_group.gregsec_dev_rg ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = var.dns_link_name
  private_dns_zone_name = azurerm_private_dns_zone.gregsec_dev_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.gregsec_dev_rg.name
  registration_enabled  = true

  depends_on = [ azurerm_private_dns_zone.gregsec_dev_dns, 
                azurerm_virtual_network.vnet,
                azurerm_resource_group.gregsec_dev_rg ]
}


resource "azurerm_postgresql_flexible_server" "postgresql_for_django" {
  name                = var.postgresql_for_django_name
  location            = var.location
  resource_group_name = var.resource_group_name
  administrator_login = "exampleadmin"
  administrator_password = "examplepassword"
  version             = "16"
  sku_name            = "B_Standard_B1ms"
  storage_mb          = 32768
  backup_retention_days = 7
  zone                = "1"
  delegated_subnet_id = azurerm_subnet.postgresql_subnet.id
  private_dns_zone_id = azurerm_private_dns_zone.gregsec_dev_dns.id

  depends_on = [ azurerm_private_dns_zone.gregsec_dev_dns, 
                azurerm_private_dns_zone_virtual_network_link.dns_link,
                azurerm_resource_group.gregsec_dev_rg,
                azurerm_subnet.postgresql_subnet ]
}

