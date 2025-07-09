resource "azurerm_postgresql_flexible_server" "postgres" {
  name                   = "${var.humber_id}-pgserver"
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
resource "azurerm_postgresql_database" "defaultdb" {
  name                = "${var.humber_id}-appdb"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_flexible_server.postgres.name
  charset             = "UTF8"
  collation           = "en_US.UTF8"
}