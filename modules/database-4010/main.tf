resource "azurerm_postgresql_flexible_server" "postgres" {
  name                   = "postgres-${var.humber_id}"
  location               = var.location
  resource_group_name    = var.resource_group_name
  administrator_login    = "pgadmin"
  administrator_password = "P@ssw0rd123!"
  version                = "14"
  storage_mb             = 32768

  sku_name = "B_Standard_B1ms"

  zone = "1"

  tags = local.tags
}
resource "azurerm_postgresql_flexible_server_database" "defaultdb" {
  name      = "postgres"
  server_id = azurerm_postgresql_flexible_server.postgres.id
  charset   = "UTF8"
  collation = "en_US.utf8"
}