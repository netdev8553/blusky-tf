output "virtual_network_name" {
  value = azurerm_virtual_network.network.name
}

output "subnet_ids" {
  value = azurerm_subnet.subnets.*.id
}
