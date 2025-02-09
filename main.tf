resource "azurerm_resource_group" "public" {
  location = var.resource_group_location
  name     = "rg-ssh-gameplay-${var.prefix}"
}

module "network" {
  source                  = "./modules/network"
  resource_group_location = azurerm_resource_group.public.location
  resource_group_name     = azurerm_resource_group.public.name
  vnet_name               = "vnet-${var.prefix}"
  nsg_name                = "nsg-${var.prefix}"
  snet_linux_name         = "subnet-linux-${var.prefix}"
  snet_windows_name       = "subnet-windows-${var.prefix}"
}

module "ubuntu-vm" {
  source                            = "./modules/ubuntu-vm-public-key-auth"
  ip_configuration_name             = "ipc-ubuntu-${var.prefix}"
  network_interface_name            = "nic-ubuntu-${var.prefix}"
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
  vm_name                           = "vm-ubuntu-${var.prefix}"
  vm_size                           = var.vm_size
  public_ip_name                    = "pip-ubuntu-${var.prefix}"
  subnet_id                         = module.network.subnet_linux_servers_id
  network_security_group_id         = module.network.network_security_group_id
  os_profile_admin_public_key_value = file("${path.root}/id_rsa.pub")

  depends_on = [
    azurerm_resource_group.public,
    module.network
  ]
}

module "windows_vm" {
  source                      = "./modules/windows-vm"
  ip_configuration_name       = "ipc-windows-${var.prefix}"
  network_interface_name      = "nic-windows-${var.prefix}"
  os_profile_admin_password   = var.os_profile_admin_password
  os_profile_admin_username   = var.os_profile_admin_username
  os_profile_computer_name    = "vm-windows-${var.prefix}"
  public_ip_name              = "pip-windows-${var.prefix}"
  resource_group_location     = azurerm_resource_group.public.location
  resource_group_name         = azurerm_resource_group.public.name
  storage_image_reference_sku = "windows-server2019-v2"
  storage_os_disk_name        = "osdisk-windows-${var.prefix}"
  subnet_id                   = module.network.subnet_windows_servers_id
  vm_name                     = "vm-windows-${var.prefix}"
  vm_size                     = var.vm_size
  image_resource_group_name   = "rg-packer-images-win"
  network_security_group_id   = module.network.network_security_group_id
  private_ip_address          = "10.0.0.10"

  depends_on = [
    module.network,
    azurerm_resource_group.public
  ]
}
