resource "azurerm_availability_set" "windows_avset" {
  name                         = "${var.humber_id}-win-avset"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
  tags                         = local.tags
}

resource "azurerm_public_ip" "win_pip" {
  count               = 1
  name                = "${var.humber_id}-win-pip-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
  domain_name_label   = "${var.humber_id}-winvm-${count.index}"

  tags = local.tags
}

resource "azurerm_network_interface" "win_nic" {
  count               = 1
  name                = "${var.humber_id}-win-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win_pip[count.index].id
  }

  tags = local.tags
}

resource "azurerm_windows_virtual_machine" "win_vm" {
  count               = 1
  name                = "${var.humber_id}-winvm-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B1ms"
  availability_set_id = azurerm_availability_set.windows_avset.id
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.win_nic[count.index].id
  ]

  os_disk {
    name                 = "${var.humber_id}-win-osdisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = var.diagnostics_storage_uri
  }

  tags = local.tags
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  name                 = "IaaSAntimalware"
  virtual_machine_id   = azurerm_windows_virtual_machine.win_vm[0].id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.5"
  auto_upgrade_minor_version = true

  settings = jsonencode({
    "AntimalwareEnabled"       = true,
    "RealtimeProtectionEnabled" = true,
    "ScheduledScanSettings" = {
      "isEnabled" = true,
      "scanType"  = "Quick",
      "day"       = 1,
      "time"      = 120
    }
  })
}
