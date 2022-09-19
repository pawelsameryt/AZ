resource "azurerm_virtual_network" "vnet01" {
    name                = "${var.prefix}-vnet01"
    location            = var.location
    resource_group_name = azurerm_resource_group.myRG.name
    address_space       = ["10.0.0.0/16"]
}
resource "azurerm_subnet" "internal-1" {
    name                    = "${var.prefix}-internal-1"
    resource_group_name     = azurerm_resource_group.myRG.name
    virtual_network_name    = azurerm_virtual_network.vnet01.name
    address_prefixes        = ["10.0.0.0/24"]
}
resource "azurerm_network_security_group" "allow-ssh" {
    name = "${var.prefix}-allow-ssh"
    location            = var.location
    resource_group_name = azurerm_resource_group.myRG.name

    security_rule {
        name                        = "SSH"
        priority                    = 1001
        direction                   = "Inbound"
        access                      = "Allow"
        protocol                    = "Tcp"
        source_port_range           = "*"
        destination_port_range      = "22"
        source_address_prefix       = var.ssh-source-address
        destination_address_prefix  = "*"
    }
}