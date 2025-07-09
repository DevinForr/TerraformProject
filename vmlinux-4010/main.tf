locals {
  vm_names = ["vm1", "vm2", "vm3"]
}

resource "azurerm_availability_set" "avset" {
  name                         = "${var.humber_id}-avset"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
  tags                         = local.tags
}

resource "azurerm_network_interface" "nic" {
  for_each = toset(local.vm_names)

  name                = "${var.humber_id}-nic-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vm_pip[each.key].id
  }

  tags = local.tags
}

resource "azurerm_public_ip" "vm_pip" {
  for_each            = toset(local.vm_names)

  name                = "${var.humber_id}-pip-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label   = "${var.humber_id}-dns-${each.key}" # must be unique across Azure

  tags = local.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each            = toset(local.vm_names)

  name                = "${var.humber_id}-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1ms"
  admin_username      = "azureuser"

  network_interface_ids = [
    azurerm_network_interface.nic[each.key].id,
  ]

  availability_set_id = azurerm_availability_set.avset.id

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.diagnostics_storage_uri
  }

  tags = local.tags
}