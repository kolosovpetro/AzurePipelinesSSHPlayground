data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "public" {
  location = var.resource_group_location
  name     = "${var.resource_group_name}-${var.prefix}"
}

module "network" {
  source                  = "git@github.com:kolosovpetro/azure-linux-vm-terraform.git//modules/network"
  resource_group_location = azurerm_resource_group.public.location
  resource_group_name     = azurerm_resource_group.public.name
  subnet_name             = "${var.subnet_name}-${var.prefix}"
  vnet_name               = "${var.vnet_name}-${var.prefix}"
}

module "ubuntu-vm" {
  source                            = "git@github.com:kolosovpetro/azure-linux-vm-terraform.git//modules/ubuntu-vm-public-key-auth"
  ip_configuration_name             = "key-auth-vm-ipconfig-${var.prefix}"
  network_interface_name            = "key-auth-vm-nic-${var.prefix}"
  os_profile_admin_public_key_path  = var.os_profile_admin_public_key_path
  os_profile_admin_username         = var.os_profile_admin_username
  os_profile_computer_name          = "key-auth-vm-${var.prefix}"
  resource_group_location           = azurerm_resource_group.public.location
  resource_group_name               = azurerm_resource_group.public.name
  storage_image_reference_offer     = var.storage_image_reference_offer
  storage_image_reference_publisher = var.storage_image_reference_publisher
  storage_image_reference_sku       = var.storage_image_reference_sku
  storage_image_reference_version   = var.storage_image_reference_version
  storage_os_disk_caching           = var.storage_os_disk_caching
  storage_os_disk_create_option     = var.storage_os_disk_create_option
  storage_os_disk_managed_disk_type = var.storage_os_disk_managed_disk_type
  storage_os_disk_name              = "key-auth-vm-osdisk-${var.prefix}"
  subnet_name                       = module.network.subnet_name
  vm_name                           = "key-auth-vm-${var.prefix}"
  vm_size                           = var.vm_size
  vnet_name                         = module.network.vnet_name
  public_ip_name                    = "key-auth-vm-ip-${var.prefix}"
  subnet_id                         = module.network.subnet_id
  nsg_name                          = "key-auth-vm-nsg-${var.prefix}"

  depends_on = [
    azurerm_resource_group.public,
    module.network
  ]
}