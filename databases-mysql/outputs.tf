output "mysql_fqdn" {
  value = azurerm_mysql_server.mysql_server.fqdn
}

output "mysql_pass" {
  value = random_password.database_password.result
}
