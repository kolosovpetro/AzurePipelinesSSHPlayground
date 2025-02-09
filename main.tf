resource "azurerm_resource_group" "public" {
  location = var.resource_group_location
  name     = "rg-ssh-gameplay-${var.prefix}"
}

module "network" {
  source                  = "git@github.com:kolosovpetro/azure-linux-vm-terraform.git//modules/network"
  resource_group_location = azurerm_resource_group.public.location
  resource_group_name     = azurerm_resource_group.public.name
  subnet_name             = "subnet-${var.prefix}"
  vnet_name               = "vnet-${var.prefix}"
}

module "ubuntu-vm" {
  source                            = "git@github.com:kolosovpetro/azure-linux-vm-terraform.git//modules/ubuntu-vm-public-key-auth"
  ip_configuration_name             = "ipc-ubuntu-${var.prefix}"
  network_interface_name            = "nic-ubuntu-${var.prefix}"
  os_profile_admin_public_key_path  = "${path.root}/id_rsa.pub"
  os_profile_admin_username         = var.os_profile_admin_username
  os_profile_computer_name          = "ubuntu-${var.prefix}"
  resource_group_location           = azurerm_resource_group.public.location
  resource_group_name               = azurerm_resource_group.public.name
  storage_image_reference_offer     = var.storage_image_reference_offer
  storage_image_reference_publisher = var.storage_image_reference_publisher
  storage_image_reference_sku       = var.storage_image_reference_sku
  storage_image_reference_version   = var.storage_image_reference_version
  storage_os_disk_caching           = var.storage_os_disk_caching
  storage_os_disk_create_option     = var.storage_os_disk_create_option
  storage_os_disk_managed_disk_type = var.storage_os_disk_managed_disk_type
  storage_os_disk_name              = "osdisk-ubuntu-${var.prefix}"
  subnet_name                       = module.network.subnet_name
  vm_name                           = "vm-ubuntu-${var.prefix}"
  vm_size                           = var.vm_size
  vnet_name                         = module.network.vnet_name
  public_ip_name                    = "pip-ubuntu-${var.prefix}"
  subnet_id                         = module.network.subnet_id
  nsg_name                          = "nsg-ubuntu-${var.prefix}"

  depends_on = [
    azurerm_resource_group.public,
    module.network
  ]
}

module "windows_vm" {
  source                      = "git@github.com:kolosovpetro/azure-windows-vm-terraform.git//modules/vm"
  ip_configuration_name       = "ipc-windows-${var.prefix}"
  network_interface_name      = "nic-windows-${var.prefix}"
  os_profile_admin_password   = var.os_profile_admin_password
  os_profile_admin_username   = var.os_profile_admin_username
  os_profile_computer_name    = "vm-windows-${var.prefix}"
  public_ip_name              = "pip-windows-${var.prefix}"
  resource_group_location     = azurerm_resource_group.public.location
  resource_group_name         = azurerm_resource_group.public.name
  storage_image_reference_sku = "2019-Datacenter"
  storage_os_disk_name        = "osdisk-windows-${var.prefix}"
  subnet_id                   = module.network.subnet_id
  vm_name                     = "vm-windows-${var.prefix}"
  vm_size                     = var.vm_size
  nsg_name                    = "nsg-windows-${var.prefix}"

  depends_on = [
    module.network,
    azurerm_resource_group.public
  ]
}
