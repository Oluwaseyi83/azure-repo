provider "azurerm" {
  features = {}
}

# Resource Group
resource "azurerm_resource_group" "example" {
  name     = "myResourceGroup"
  location = "East US" # Change this to your desired region
}

# Virtual Network
resource "azurerm_virtual_network" "example" {
  name                = "myVNet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

# Availability Zones
resource "azurerm_subnet" "public_subnet_1" {
  name                 = "public_subnet_1"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
  zone                 = 1
}

resource "azurerm_subnet" "public_subnet_2" {
  name                 = "public_subnet_2"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  zone                 = 2
}

resource "azurerm_subnet" "private_subnet_1" {
  name                 = "private_subnet_1"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.3.0/24"]
  zone                 = 1
}

resource "azurerm_subnet" "private_subnet_2" {
  name                 = "private_subnet_2"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.4.0/24"]
  zone                 = 2
}

# Security Group
resource "azurerm_network_security_group" "example" {
  name                = "myNSG"
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Public Virtual Machines
resource "azurerm_virtual_machine" "public_vm_1" {
  count                 = 2
  name                  = "public-vm-${count.index + 1}"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  availability_set_id   = azurerm_availability_set.example.id
  network_interface_ids = [azurerm_network_interface.public_nic_1[count.index].id]
  size                  = "Standard_DS1_v2"

  # (OS disk configuration, etc.)

  # Example: Provisioning a basic Ubuntu VM
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname-${count.index + 1}"
    admin_username = "adminuser"
    admin_password = "Password1234!" # Change this to a secure password
  }
}

# Similar resource block for the second public subnet's VMs

# Private Virtual Machines
resource "azurerm_virtual_machine" "private_vm_1" {
  count                 = 2
  name                  = "private-vm-${count.index + 1}"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  availability_set_id   = azurerm_availability_set.example.id
  network_interface_ids = [azurerm_network_interface.private_nic_1[count.index].id]
  size                  = "Standard_DS1_v2"

  # (OS disk configuration, etc.)

  # Example: Provisioning a basic Ubuntu VM
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "osdisk-${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname-${count.index + 1}"
    admin_username = "adminuser"
    admin_password = "Password1234!" # Change this to a secure password
  }
}

# Similar resource block for the second private subnet's VMs

# Availability Set
resource "azurerm_availability_set" "example" {
  name                = "myAvailabilitySet"
  resource_group_name = azurerm_resource_group.example.name
}

# Public Network Interface
resource "azurerm_network_interface" "public_nic_1" {
  count               = 2
  name                = "public-nic-${count.index + 1}"
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "ipconfig-${count.index + 1}"
    subnet_id                     = azurerm_subnet.public_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Similar resource block for the second public subnet's NICs

# Private Network Interface
resource "azurerm_network_interface" "private_nic_1" {
  count               = 2
  name                = "private-nic-${count.index + 1}"
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "ipconfig-${count.index + 1}"
    subnet_id                     = azurerm_subnet.private_subnet_1.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Similar resource block for the second private subnet's NICs



provider "azurerm" {
  features = {}
}

resource "azurerm_resource_group" "example" {
  name     = "myResourceGroup"
  location = "East US" # Change this to your desired region
}

resource "azurerm_virtual_network" "example" {
  name                = "myVNet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_availability_set" "example" {
  name                = "myAvailabilitySet"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  platform_fault_domain_count = 2
}

resource "azurerm_subnet" "subnet_az1_1" {
  name                 = "subnet-az1-1"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
  availability_zone    = 1
}

resource "azurerm_subnet" "subnet_az1_2" {
  name                 = "subnet-az1-2"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
  availability_zone    = 1
}

resource "azurerm_subnet" "subnet_az2_1" {
  name                 = "subnet-az2-1"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.3.0/24"]
  availability_zone    = 2
}

resource "azurerm_subnet" "subnet_az2_2" {
  name                 = "subnet-az2-2"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.4.0/24"]
  availability_zone    = 2
}




resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_network_security_group" "example" {
  name                = "example-security-group"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = "example-network"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Production"
  }
}

