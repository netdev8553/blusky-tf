output "lb_be_address_pool_id" {
  value = azurerm_lb_backend_address_pool.lb_address_pool.id
}

output "lb_nat_rule_id" {
  value = azurerm_lb_nat_rule.nat-rule.id
}
