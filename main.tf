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

}

resource "azurerm_resource_group" "pipelinerg"{
  name="pipelinerg"
  location="West Europe"
}


resource "azurerm_storage_account" "pipelinesa" {
  name                     = "pipelinesa2"
  resource_group_name      = azurerm_resource_group.pipelinerg.name
  location                 = azurerm_resource_group.pipelinerg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

# Here we are creating a container in the storage account
resource "azurerm_storage_container" "pipelinecontainer2" {
  name                  = "pipelinecontainer2"
  storage_account_name  = azurerm_storage_account.pipelinesa.name
  container_access_type = "private"
}