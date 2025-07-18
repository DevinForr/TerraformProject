variable "humber_id" {
  type        = string
  description = "Humber ID last 4 digits"
    default     = "4010"
}

variable "location" {}

variable "resource_group_name" {}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to attach the NIC"
  default     = null
}

variable "nsg_id" {
  type        = string
  description = "Network Security Group ID (optional, if used)"
  default     = null
}

variable "diagnostics_storage_uri" {
  type        = string
  description = "URI of the storage account used for VM boot diagnostics"
    default     = null
}

locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }


}

variable "linux_vm_ids" {
  type    = map(string)
  default = {}
}

variable "backend_pool_id" {
  description = "ID of the backend address pool from the load balancer"
  type        = string
}