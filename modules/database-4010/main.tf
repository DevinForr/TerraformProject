resource "azurerm_postgresql_flexible_server" "postgres" {
  name                   = "${var.humber_id}-pgserver"
  location               = var.location
  resource_group_name    = var.resource_group_name
  sku_name               = "B1ms"
  administrator_login    = "pgadmin"
  administrator_password = "P@ssw0rd123!"
  storage_mb             = 32768
  version                = "14"

  zone                   = "1"

  tags = local.tags
}
resource "azurerm_postgresql_database" "defaultdb" {
  name                = "${var.humber_id}-appdb"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgres.name
  charset             = "UTF8"
  collation           = "en_US.UTF8"
}