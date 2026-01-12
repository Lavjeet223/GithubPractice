terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.57.0"
    }
  }
}

provider "azurerm" {
  features {}

}

resource "azurerm_resource_group" "backendrg" {
  name     = "Backend-rg"
  location = "southindia"
}

resource "azurerm_storage_account" "backendstg" {
  name                     = "lavbackendstg"
  resource_group_name      = azurerm_resource_group.backendrg.name
  location                 = azurerm_resource_group.backendrg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "backendcontainer" {
  name                  = "tfstate"
  storage_account_id  = azurerm_storage_account.backendstg.id
  container_access_type = "private"
}
