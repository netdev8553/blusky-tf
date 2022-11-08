resource "azurerm_public_ip" "lb_ip" {
  name                = "lb-public-ip"
  location            = var.region
  resource_group_name = var.rg_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.region
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = "public-ip"
    public_ip_address_id = azurerm_public_ip.lb_ip.id
  }
}

resource "azurerm_lb_nat_rule" "nat-rule" {
  resource_group_name            = var.rg_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "nat-rule-01"
  protocol                       = var.nat_protocol
  frontend_port                  = var.nat_frontend_port
  backend_port                   = var.nat_backend_port
  frontend_ip_configuration_name = "public-ip"
}

resource "azurerm_lb_backend_address_pool" "lb_address_pool" {
  resource_group_name = var.rg_name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = var.backend_address_pool_name
}
