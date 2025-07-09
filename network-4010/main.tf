resource "azurerm_virtual_network" "vnet" {
  name                = "${var.humber_id}-VNET"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.humber_id}-SUBNET"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.humber_id}-NSG"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
}

resource "azurerm_network_security_rule" "allow_ports" {
  for_each = {
    SSH   = 22
    RDP   = 3389
    WINRM = 5985
    HTTP  = 80
  }

  name                        = "allow-${each.key}"
  priority                    = 100 + index(keys({ SSH = 22, RDP = 3389, WINRM = 5985, HTTP = 80 }), each.key)
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}