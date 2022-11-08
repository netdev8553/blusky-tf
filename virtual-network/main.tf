resource "azurerm_virtual_network" "network" {
  name                = var.network_name
  address_space       = [var.network_address_space]
  location            = var.region
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "subnets" {
  count                = var.subnet_count
  name                 = join("", [var.subnet_name, "-subnet-", count.index])
  address_prefix       = cidrsubnet(join("", azurerm_virtual_network.network.address_space), 8, count.index)
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.network.name
}
