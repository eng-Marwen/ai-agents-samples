terraform {              
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm" # Provider source
      version = "~> 4.0"
    }
  }
}

provider "azurerm" { # Configure Azure provider
  features {}
}