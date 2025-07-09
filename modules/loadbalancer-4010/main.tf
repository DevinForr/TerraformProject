resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.humber_id}-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label = "n${lower(replace(var.humber_id, "[^a-z0-9-]", ""))}-lb"

  tags = local.tags
}

resource "azurerm_lb" "load_balancer" {
  name                = "n${var.humber_id}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Basic"

  frontend_ip_configuration {
    name                 = "PublicFrontend"
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }

  tags = local.tags
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name            = "${var.humber_id}-lb-backend"
  loadbalancer_id = azurerm_lb.load_balancer.id
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_assoc" {
  for_each = var.linux_nic_ids

  network_interface_id    = each.value
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

