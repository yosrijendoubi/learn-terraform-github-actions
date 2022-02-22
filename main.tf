terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.96.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "storagewas"
    container_name       = "edge"
    key                  = "terraform.tfstate"
    resource_group_name  = "iotStorageYosri"
  }
  
}


provider "azurerm" {
  features {}

  subscription_id = "564aa9d4-9031-49bc-9320-124b01c9d64c"
  client_id       = "b3ad2679-9a3b-41ed-a05b-03cfd9a4d4b6"
  client_secret   = "7VEmIQN3g6c_Z2d5litZY1Rb7_kjgFtxVq"
  tenant_id       = "604f1a96-cbe8-43f8-abbf-f8eaf5d85730"
  access_key      = "11FN5TUG5t/pEC3Plkf6UmQr6hHQFP2sc1VNnUb0CZsRiFm/wWPdwg0O8n5YjYnp11XBeOqv18G0a/NYyxcWQg=="
}

resource "azurerm_resource_group" "iotStorage"{
  name="PipeLineRG"
  location="West Europe"
}


resource "azurerm_storage_account" "storagewas" {
  name                     = "PipeLineSA"
  resource_group_name      = azurerm_resource_group.iotStorage.name
  location                 = azurerm_resource_group.iotStorage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

# Here we are creating a container in the storage account
resource "azurerm_storage_container" "edge" {
  name                  = "PipeLineContainer"
  storage_account_name  = azurerm_storage_account.storagewas.name
  container_access_type = "private"
}