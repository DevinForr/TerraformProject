terraform {
   backend "azurerm" {
     resource_group_name  = "rgroup-4010"
      storage_account_name = "4010commonstore"
     container_name       = "tfstate"
   key                  = "assignment1-4010.tfstate"
   }
 }
