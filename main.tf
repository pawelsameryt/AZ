terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~>3.0.2"
        }
    }
    required_version = ">=1.1.0"
} 
provider "azurerm" {
  features{}
}

#create a resource group
resource "azurerm_resource_group" "myRG" {
    name = "myRG"
    location = var.location
}