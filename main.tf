# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = "southeastasia"

  tags = {
    Environment = "Terraform Getting Started"
    Team        = "DevOps"
    test-policy = "tag-value"
    Role        = "Infra"

  }

}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "myTFVnet"
  address_space       = ["10.0.0.0/16"]
  location            = "southeastasia"
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_storage_account" "example" {
  name                     = "gerlitochagas"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "Staging"
    sample_tag  = "dev"
    test-policy = "tag-value"
  }
}
