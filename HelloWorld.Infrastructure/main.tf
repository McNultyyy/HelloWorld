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
  name     = "hwresourcegroup"
  location = "${var.location}"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "hwstorage"
  resource_group_name      = "${azurerm_resource_group.resourcegroup.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags {
    application = "${var.applicationname}"
  }
}

