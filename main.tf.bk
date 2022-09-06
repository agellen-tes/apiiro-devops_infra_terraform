# Provides configuration details for Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "resource_group_agellen" { 
  # resource <resource type> <local name/ref in the configuration>
  name     = "agellen-euw-terraform"
  location = "West Europe"
  tags = {
    environment = "dev"
    source = "Terraform"
    owner = "Aron Gellen"
  }
}
