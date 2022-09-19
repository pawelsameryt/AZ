#create vm
resource "azurerm_virtual_machine" "vm01" {
  name                  = "${var.prefix}-vm01" 
  location              = var.location
  resource_group_name   = azurerm_resource_group.myRG.name
  network_interface_ids = [azurerm_network_interface.nic01.id]
  vm_size               = "Standard_B2s"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true
  
  storage_image_reference {
    publisher   = "Cannonical"
    offer       = "UbuntuServer"
    sku         = "16.04-LST"
    version     = "latest"
  }
  storage_os_disk {
    name                    = "myosdisk1"
    caching                 = "ReadWrite"
    create_option           = "FromImage"
    managed_disk_type = "Standard_LRS" 
  }
  os_profile {
    computer_name   = "${var.prefix}-vm01"
    admin_username  = "pafcio"
    #admin_password = ""
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
        key_data = file("mykey.pub")
        path = "/home/pafcio/.ssh/authorized_keys"
    }
  }
}
resource "azurerm_network_interface" "nic01" {
  name                      = "${var.prefix}-nic01"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.myRG.name

  ip_configuration {
    name                            = "ip01"
    subnet_id                       = azurerm_subnet.internal-1.id
    private_ip_address_allocation   = "Dyanmic"
    public_ip_address_id = azurerm_public_ip.ip01.id
  } 
}
resource "azurerm_subnet_network_security_group_association" "sec-group-associoation" {
    subnet_id                 = azurerm_subnet.internal-1.id
    network_security_group_id = azurerm_network_security_group.allow-ssh.id
}

resource "azurerm_public_ip" "ip01" {
    name                = "ip01"
    location            = var.location
    resource_group_name = azurerm_resource_group.myRG.name
    allocation_method   = "Dynamic"
}
