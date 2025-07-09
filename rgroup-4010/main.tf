resource "azurerm_resource_group" "this" {
  name     = "${var.humber_id}-RG"
  location = var.location

tags = local.tags
}