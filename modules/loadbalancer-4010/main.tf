resource "azurerm_public_ip" "lb_public_ip" {
  name                = "${var.humber_id}-lb-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label   = "n${lower(var.humber_id)}-lb"
  tags                = local.tags
}

resource "azurerm_lb" "load_balancer" {
  name                = "${var.humber_id}-lb"
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
   for_each = {
    vm1 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Network/networkInterfaces/4010-nic-vm1"
    vm2 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Network/networkInterfaces/4010-nic-vm2"
    vm3 = "/subscriptions/6d9bf65c-e849-4efc-9343-a8daff569d0c/resourceGroups/rgroup-4010/providers/Microsoft.Network/networkInterfaces/4010-nic-vm3"
  }


  network_interface_id    = each.value
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}