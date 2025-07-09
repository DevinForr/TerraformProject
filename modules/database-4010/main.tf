resource "azurerm_postgresql_server" "postgres" {
  name                = "${var.humber_id}-pgserver"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "B_Gen5_1"
  storage_mb          = 5120
  backup_retention_days = 7
  auto_grow_enabled      = true
  administrator_login    = var.admin_username
  administrator_login_password = var.admin_password
  version               = "11"

  ssl_enforcement_enabled = true
  public_network_access_enabled = true

  tags = local.tags
}

resource "azurerm_postgresql_database" "defaultdb" {
  name                = "${var.humber_id}-appdb"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_postgresql_server.postgres.name
  charset             = "UTF8"
  collation           = "en_US.UTF8"
}