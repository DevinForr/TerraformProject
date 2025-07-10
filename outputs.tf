output "resource_group" {
  value = module.rgroup.resource_group_name
}

output "vnet" {
  value = module.network.virtual_network_name
}

output "subnet" {
  value = module.network.subnet_name
}

output "log_analytics_workspace" {
  value = module.common.log_analytics_workspace_name
}

output "recovery_services_vault" {
  value = module.common.recovery_services_vault_name
}

output "storage_account" {
  value = module.common.storage_account_name
}

output "linux_vm_hostnames" {
  value = module.linux_vms.hostnames
}

output "linux_vm_public_ips" {
  value = module.linux_vms
}

output "win_vm_hostname" {
  value = module.win_vm.hostname
}

output "win_vm_public_ip" {
  value = module.win_vm.public_ip
}

output "load_balancer" {
  value = module.loadbalancer.load_balancer_name
}

output "postgres_server" {
  value = module.database.postgres_server_name
}

output "postgres_fqdn" {
  value = module.database.postgres_fqdn
}