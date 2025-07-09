resource "azurerm_managed_disk" "datadisk" {
  for_each = zipmap(var.vm_ids, var.vm_ids)

  name                 = "${var.humber_id}-datadisk-${each.key}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 10
  tags                 = local.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach_disk" {
  for_each = var.vm_ids

  managed_disk_id    = azurerm_managed_disk.datadisk[each.key].id
  virtual_machine_id = each.value
  lun                = 0
  caching            = "ReadWrite"
}