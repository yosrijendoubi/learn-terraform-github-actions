terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.96.0"
    }
  }

  /*backend "azurerm" {
    storage_account_name = "edgepfe"
    container_name       = "edgeblob"
    key                  = "terraform.tfstate"
    resource_group_name  = "iotstorage"
  }*/

  required_version = ">= 1.1.0"

  cloud {
    organization = "triware"

    workspaces {
      name = "gh-actions-demo"
    }
  }
  
}


provider "azurerm" {
  features {}

  /*subscription_id = "564aa9d4-9031-49bc-9320-124b01c9d64c"
  client_id       = "19763837-18bb-462b-b3f1-38c208328417"
  client_secret   = "7VEmIQN3g6c_Z2d5litZY1Rb7_kjgFtxVq"
  tenant_id       = "b3ad2679-9a3b-41ed-a05b-03cfd9a4d4b6"*/
}

resource "azurerm_resource_group" "iotStorage"{
  name="iotStorageYosri"
  location="West Europe"
}


resource "azurerm_storage_account" "storagewas" {
  name                     = "storagewas"
  resource_group_name      = azurerm_resource_group.iotStorage.name
  location                 = azurerm_resource_group.iotStorage.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

# Here we are creating a container in the storage account
resource "azurerm_storage_container" "edge" {
  name                  = "edge"
  storage_account_name  = azurerm_storage_account.storagewas.name
  container_access_type = "private"
}