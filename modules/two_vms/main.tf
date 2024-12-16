
resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "southeastasia"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet1"
  address_space       = ["10.1.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "default" {
  name                 = "default"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  security_rule {
    name                       = "AllowRDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  count               = 2
  name                = "nic${count.index + 1}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
}

resource "azurerm_public_ip" "public_ip" {
  count               = 2
  name                = "public-ip-${count.index + 1}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_rule" "nsg_rule" {
  count                         = 2
  name                          = "AllowRDP-${count.index + 1}"
  priority                      = 1000 + count.index
  direction                     = "Inbound"
  access                           = "Allow"
  protocol                      = "Tcp"
  source_port_range             = "*"
  destination_port_range        = "*"
  source_address_prefix         = "*"
  destination_address_prefix    = "*"
  resource_group_name           = azurerm_resource_group.example.name
  network_security_group_name   = azurerm_network_security_group.nsg.name
}

resource "azurerm_windows_virtual_machine" "vm" {
  count               = 2
  name                = "vm${count.index + 1}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_DS1_v2"
  admin_username      = "adminuser"
  admin_password      = var.admin_password

  network_interface_ids = [azurerm_network_interface.nic[count.index].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  tags = {
    environment = "test"
  }
}