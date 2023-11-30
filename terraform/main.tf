resource "azurerm_virtual_network" "devops-vn" {
  name                = "devops-network"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = "tp-devops-test"
}

resource "azurerm_subnet" "devops-sub" {
  name                 = "devops-subnet"
  resource_group_name  =  "tp-devops-test"
  virtual_network_name = azurerm_virtual_network.devops-vn.name
  address_prefixes    = ["10.0.0.0/24"]
}

resource "azurerm_network_interface" "devops-nic" {
  name                = "devops-nic"
  location            = "East US"
  resource_group_name =  "tp-devops-test"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.devops-sub.id
    private_ip_address            = "10.0.0.5"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "devops-wvm" {
  name                  = "devops-vm"
  resource_group_name   =  "tp-devops-test"
  location              = "East US"
  size                  = "Standard_D2s_v3"
  admin_username        = "azureuser"
  admin_password        = "nadineTest123*"

  network_interface_ids = [azurerm_network_interface.devops-nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
