locals {
  humber_id = "4010"
  location  = "East US"
  tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "firstname.lastname"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
  vm_names = ["vm1", "vm2", "vm3"]
}

module "rgroup" {
  source              = "./modules/rgroup-4010"
  humber_id           = local.humber_id
  location            = local.location
}

module "common" {
  source              = "./modules/common-4010"
  resource_group_name = module.rgroup.resource_group_name
  location            = local.location
}
module "linux_vms" {
  source              = "./modules/vmlinux-4010"
  humber_id           = local.humber_id
  location            = local.location
  resource_group_name = module.rgroup.resource_group_name
  subnet_id           = module.network.subnet_id
  backend_pool_id     = module.loadbalancer.backend_pool_id
  # Handle NIC associations inside linux_vms module using backend_pool_id
}

module "loadbalancer" {
  source              = "./modules/loadbalancer-4010"
  humber_id           = local.humber_id
  location            = local.location
  resource_group_name = module.rgroup.resource_group_name
  # Remove linux_nic_ids input here
  depends_on          = [module.network] # if needed
}
module "network" {
  source              = "./modules/network-4010"
  humber_id           = local.humber_id
  location            = local.location
  resource_group_name = module.rgroup.resource_group_name
}


module "win_vm" {
  source                  = "./modules/vmwindows-4010"
  humber_id               = local.humber_id
  location                = local.location
  resource_group_name     = module.rgroup.resource_group_name
  subnet_id               = module.network.subnet_id
  diagnostics_storage_uri = "https://${module.common.storage_account_name}.blob.core.windows.net/"
  admin_username          = "azureadmin"
  admin_password          = "SecureP@ss123!" # Use secrets in real deployments
}

module "datadisk" {
  source              = "./modules/datadisk-4010"
  humber_id           = local.humber_id
  location            = local.location
  resource_group_name = module.rgroup.resource_group_name
  vm_ids = {
   vm1 = module.linux_vms.vm_ids["vm1"]
vm2 = module.linux_vms.vm_ids["vm2"]
vm3 = module.linux_vms.vm_ids["vm3"]
  win = module.win_vm.vm_id
}
}

module "database" {
  source              = "./modules/database-4010"
  humber_id           = local.humber_id
  location            = local.location
  resource_group_name = module.rgroup.resource_group_name
  admin_username      = "pgadmin"
  admin_password      = "SecureP@ssword123"
}