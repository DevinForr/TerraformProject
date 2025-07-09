locals {
  humber_id = "1234"
  location  = "canadacentral"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "firstname.lastname"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}

module "rgroup" {
  source     = "./modules/rgroup-1234"
  humber_id  = local.humber_id
  location   = local.location
  tags       = local.tags
}

module "network" {
  source              = "./modules/network-1234"
  humber_id           = local.humber_id
  location            = local.location
  resource_group_name = module.rgroup.resource_group_name
  tags                = local.tags
}

module "common" {
  source              = "./modules/common-1234"
  humber_id           = local.humber_id
  location            = local.location
  resource_group_name = module.rgroup.resource_group_name
  tags                = local.tags
}

module "linux_vms" {
  source                  = "./modules/vmlinux-1234"
  humber_id               = local.humber_id
  location                = local.location
  resource_group_name     = module.rgroup.resource_group_name
  subnet_id               = module.network.subnet_id
  diagnostics_storage_uri = "https://${module.common.storage_account_name}.blob.core.windows.net/"
  tags                    = local.tags
}

module "win_vm" {
  source                  = "./modules/vmwindows-1234"
  humber_id               = local.humber_id
  location                = local.location
  resource_group_name     = module.rgroup.resource_group_name
  subnet_id               = module.network.subnet_id
  diagnostics_storage_uri = "https://${module.common.storage_account_name}.blob.core.windows.net/"
  admin_username          = "azureadmin"
  admin_password          = "SecureP@ss123!" # Use secrets in real deployments
  tags                    = local.tags
}

module "datadisk" {
  source              = "./modules/datadisk-1234"
  humber_id           = local.humber_id
  location            = local.location
  resource_group_name = module.rgroup.resource_group_name
  vm_ids = merge(
    module.linux_vms.vm_ids,
    { win = module.win_vm.vm_id }
  )
  tags = local.tags
}

module "loadbalancer" {
  source              = "./modules/loadbalancer-1234"
  humber_id           = local.humber_id
  location            = local.location
  resource_group_name = module.rgroup.resource_group_name
  linux_nic_ids       = module.linux_vms.nic_ids
  tags                = local.tags
}

module "database" {
  source              = "./modules/database-1234"
  humber_id           = local.humber_id
  location            = local.location
  resource_group_name = module.rgroup.resource_group_name
  admin_username      = "pgadmin"
  admin_password      = "SecureP@ssword123"
  tags                = local.tags
}