output "datadisk_ids" {
  description = "Map of data disk names to their IDs"
  value       = { for k, v in azurerm_managed_disk.datadisk : k => v.id }
}

