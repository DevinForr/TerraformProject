

resource "azurerm_availability_set" "avset" {
  name                         = "${var.humber_id}-avset"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
  tags                         = local.tags
}

resource "azurerm_public_ip" "vm_pip" {
  for_each            = toset(local.vm_names)

  name                = "${var.humber_id}-pip-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label   = "n${var.humber_id}-dns-${each.key}"

  tags = local.tags
}
resource "azurerm_network_interface" "nic" {
  for_each = toset(["vm1", "vm2", "vm3"])

  name                = "4010-nic-${each.key}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = azurerm_network_interface.nic

  name                  = "4010-${each.key}"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [each.value.id]
  size                  = "Standard_B1s"
  admin_username        = "azureuser"
  admin_password        = "P@ssword123!" # don't use in production
  disable_password_authentication = false
  availability_set_id = azurerm_availability_set.avset.id

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    name                 = "${each.key}-osdisk"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}