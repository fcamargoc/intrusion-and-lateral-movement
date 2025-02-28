
provider "azurerm" {
  features {}
  subscription_id = var.suscripcion
}



resource "azurerm_resource_group" "rg" {
  name     = "pruebastesting"
  location = var.location
}

# Red Virtual
resource "azurerm_virtual_network" "vnet" {
  name                = "testing-vnet"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.1.0/24"]
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "testing-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
# IP PUBLICA

resource "azurerm_public_ip" "public_ip" {
  name                = "testing-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"  # Puede ser "Static" o "Dynamic"
  sku                 = "Basic"  # Recomendado para alta disponibilidad
}

# Interfaz de red
resource "azurerm_network_interface" "nic" {
  name                = "testing-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_storage_account" "storage" {
  name                     = "mistorageaccount${random_integer.random.result}" # Usando random para unicidad
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Recurso File System (Compartimiento de Archivos)
resource "azurerm_storage_share" "fileshare" {
  name                 = "mifileshare"
  storage_account_name = azurerm_storage_account.storage.name
  quota                = 50 # Tamaño en GB
}



# Máquina Virtual
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "testing-ubuntu-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic.id]

  # Autenticación con usuario y contraseña
  disable_password_authentication = false
  admin_password                  = var.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  # Ejecutar el script bash
  custom_data = base64encode(<<-EOF
#!/bin/bash

# Actualizar los paquetes
sudo apt update -y

# Instalar paquetes
sudo apt install cifs-utils -y
sudo mkdir /mnt/azurefiles

echo "script finalizado"
    EOF
  )

  tags = {
    environment = "Terraform"
  }
}
# Recurso random_integer para nombre único del storage account
resource "random_integer" "random" {
  min = 10000
  max = 99999
}

# Output para mostrar el nombre del Storage Account
output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

# Output para mostrar el nombre del file share
output "file_share_name" {
  value = azurerm_storage_share.fileshare.name
}

