terraform {
  backend "azurerm" {
    storage_account_name = "terraformaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
    version = "=1.20.00"
}


variable "applicationname" {
    default = "helloworld"
}
variable "location" {
    default = "uksouth"
}


resource "azurerm_resource_group" "resourcegroup" {
  name     = "hwresourcegroup01"
  location = "${var.location}"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "hwstorage01"
  resource_group_name      = "${azurerm_resource_group.resourcegroup.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS",
  account_kind             = "StorageV2"

  tags {
    application = "${var.applicationname}"
  }
}

resource "azurerm_storage_container" "storagecontainer" {
  name                  = "www"
  resource_group_name   = "${azurerm_resource_group.resourcegroup.name}"
  storage_account_name  = "${azurerm_storage_account.storageaccount.name}"
  container_access_type = "private"
}