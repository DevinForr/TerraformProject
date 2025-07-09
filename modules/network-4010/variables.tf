variable "humber_id" {
  default = "4010"
}

variable "location" {
  default = "East US"
  type        = string
}

variable "resource_group_name" {
  default = "4010-RG"
}

locals {
  tags = {Assignment = "CCGC 5502 Automation Assignment"
Name = "firstname.lastname"
ExpirationDate = "2024-12-31"
Environment = "Learning"
  }
}
