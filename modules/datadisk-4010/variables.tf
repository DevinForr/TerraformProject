variable "humber_id" {
  default = "4010"
}

variable "location" {
  default = "East US"   
}

variable "resource_group_name" {
  default = "rgroup-4010"
}

variable "vm_names" {
  type    = list(string)
  default = ["vm0", "vm1", "vm2", "win"]
}

variable "vm_ids" {
  type = map(string)
}
locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }
}