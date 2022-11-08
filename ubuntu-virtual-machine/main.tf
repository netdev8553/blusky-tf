# Create a Network Security group
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.region
  resource_group_name = var.rg_name
}

# Allow Outbound Traffic
resource "azurerm_network_security_rule" "nsg-rule-01" {
  name                        = join("", [var.nsg_name, "-outbound-rule-01"])
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Allow Inbound Traffic on Port 22 to the IP specified in var.admin_cidr_ingress
resource "azurerm_network_security_rule" "nsg-rule-02" {
  name                        = join("", [var.nsg_name, "-inbound-rule-01"])
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "22"
  destination_port_range      = "22"
  source_address_prefix       = var.admin_cidr_ingress
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Create the Network Interface for the VM
resource "azurerm_network_interface" "net-interface" {
  name                = join("", [var.virtual_network_name, "-network-interface-01"])
  location            = var.region
  resource_group_name = var.rg_name

 ip_configuration {
   name                          = "internal"
   subnet_id                     = var.subnet_1_id
   private_ip_address_allocation = "Dynamic"
   public_ip_address_id          = azurerm_public_ip.public-ip.id
  }
}

# Create the Public IP for the VM
resource "azurerm_public_ip" "public-ip" {
  name                = join("", [var.virtual_network_name, "-public-ip-01"])
  location            = var.region
  resource_group_name = var.rg_name
  allocation_method   = "Static"
}

# Create the Virtual Machine Resource
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = var.rg_name
  location              = var.region
  size                  = var.vm_size
  admin_username        = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.net-interface.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
 }
}
