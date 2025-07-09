variable "humber_id" {
  default = "4010"
}

variable "location" {
  default = "East US"   
}

variable "resource_group_name" {
  default = "rgroup-4010"
}


variable "vm_ids" {
    description = "List of VM IDs to attach the data disk to"
    type        = list(string)
    default     = []
}

locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }
}