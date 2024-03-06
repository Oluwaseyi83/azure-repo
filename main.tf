# Create a Resource Group
resource "azurerm_resource_group" "testrg" {
  name     = "myResourceGroup"
  location = "East US" # Change this to your desired region
}

#  Create Virtual Network
resource "azurerm_virtual_network" "testvn" {
  name                = "mytestVNet"
  resource_group_name = azurerm_resource_group.testrg.name
  location            = azurerm_resource_group.testrg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_availability_set" "azset" {
  name                = "myAvailabilitySet"
  resource_group_name = azurerm_resource_group.testrg.name
  location            = azurerm_resource_group.testrg.location
  platform_fault_domain_count = 2 # Specify the number of fault domains (availability zones)
  platform_update_domain_count = 2

  # Additional settings can be configured here if needed
}
# Create Availability Zones
resource "azurerm_subnet" "public_subnet_1" {
  name                 = "public_subnet_1"
  resource_group_name  = azurerm_resource_group.testrg.name
  virtual_network_name = azurerm_virtual_network.testvn.name 
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "public_subnet_2" {
  name                 = "public_subnet_2"
  resource_group_name  = azurerm_resource_group.testrg.name
  virtual_network_name = azurerm_virtual_network.testvn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_subnet" "private_subnet_1" {
  name                 = "private_subnet_1"
  resource_group_name  = azurerm_resource_group.testrg.name
  virtual_network_name = azurerm_virtual_network.testvn.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_subnet" "private_subnet_2" {
  name                 = "private_subnet_2"
  resource_group_name  = azurerm_resource_group.testrg.name
  virtual_network_name = azurerm_virtual_network.testvn.name
  address_prefixes     = ["10.0.4.0/24"]
}

