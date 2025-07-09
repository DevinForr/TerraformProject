output "log_analytics_workspace_name" {
  value       = azurerm_log_analytics_workspace.log_workspace.name
  description = "Log Analytics Workspace name"
}

output "recovery_services_vault_name" {
  value       = azurerm_recovery_services_vault.recovery_vault.name
  description = "Recovery Services Vault name"
}

output "storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "Standard storage account name"
}