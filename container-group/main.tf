# If var.is_private_ip = true, create the resource
resource "azurerm_subnet" "container_subnet" {
  count = var.is_private_ip ? 1 : 0
  name                 = "container-subnet"
  address_prefix       = var.container_address_prefix
  resource_group_name  = var.rg_name
  virtual_network_name = var.virtual_network_name

  delegation {
    name = "delegation"

    service_delegation {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

# If var.is_private_ip = true, create the resource
resource "azurerm_container_group" "group_private" {
  count = var.is_private_ip ? 1 : 0

  name                = var.container_group_name
  location            = var.region
  resource_group_name = var.rg_name
  ip_address_type     = "Private"
  network_profile_id  = azurerm_network_profile.profile[0].id
  os_type             = var.container_os

  container {
    name   = "nginx"
    image  = "nginx:latest"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 443
      protocol = "TCP"
    }
  }

  container {
    name   = "php"
    image  = "php:7.4-fpm"
    cpu    = "0.5"
    memory = "1.0"
  }
}

# If var.is_private_ip = false, create the resource
resource "azurerm_container_group" "group_public" {
  count = var.is_private_ip ? 0 : 1

  name                = var.container_group_name
  location            = var.region
  resource_group_name = var.rg_name
  ip_address_type     = "Public"
  dns_name_label      = var.dns_name
  os_type             = var.container_os

  container {
    name   = "nginx"
    image  = "nginx:latest"
    cpu    = "0.5"
    memory = "1.0"

    ports {
      port     = 443
      protocol = "TCP"
    }
  }

  container {
    name   = "php"
    image  = "php:7.4-fpm"
    cpu    = "0.5"
    memory = "1.0"
  }
}

# If var.is_private_ip = true, create the resource
resource "azurerm_network_profile" "profile" {
  count = var.is_private_ip ? 1 : 0

  name                = "containernetworkprofile"
  location            = var.region
  resource_group_name = var.rg_name

  container_network_interface {
    name = "containernic"

    ip_configuration {
      name      = "containerconfig"
      subnet_id = azurerm_subnet.container_subnet[0].id
    }
  }
}
