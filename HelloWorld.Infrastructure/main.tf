provider "azurerm" {
    version = "=1.20.00"
}


variable "applicationname" {
    default = "helloworld"
}
variable "resourcegroup" {
    default = "hw-rs-01"
}
variable "location" {
    default = "uksouth"
}


resource "azurerm_resource_group" "resourcegroup" {
  name     = "${var.resourcegroup}"
  location = "${var.location}"
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "storageaccountname"
  resource_group_name      = "${azurerm_resource_group.testrg.name}"
  location                 = "${var.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags {
    application = "${var.applicationname}"
  }
}

