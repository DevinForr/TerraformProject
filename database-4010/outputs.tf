output "postgres_server_name" {
  description = "Name of the PostgreSQL server"
  value       = azurerm_postgresql_server.postgres.name
}

output "postgres_fqdn" {
  description = "FQDN of the PostgreSQL server"
  value       = azurerm_postgresql_server.postgres.fqdn
}