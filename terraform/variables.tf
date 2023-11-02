variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "resource_group_location" {
  type        = string
  description = "Resource group location"
}

variable "prefix" {
  type        = string
  description = "Prefix for all resources"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
}
variable "vnet_name" {
  type        = string
  description = "Vnet name"
}

variable "os_profile_admin_public_key_path" {
  type        = string
  description = "Path to public key"
}

variable "os_profile_admin_username" {
  type        = string
  description = "Admin username"
}

variable "storage_image_reference_offer" {
  type        = string
  description = "Offer"
}

variable "storage_image_reference_publisher" {
  type        = string
  description = "Publisher"
}

variable "storage_image_reference_sku" {
  type        = string
  description = "SKU"
}

variable "storage_image_reference_version" {
  type        = string
  description = "Version"
}

variable "storage_os_disk_caching" {
  type        = string
  description = "Caching"
}

variable "storage_os_disk_create_option" {
  type        = string
  description = "Create option"
}

variable "storage_os_disk_managed_disk_type" {
  type        = string
  description = "Managed disk type"
}

variable "vm_size" {
  type        = string
  description = "VM size"
}

variable "os_profile_admin_password" {
  type        = string
  description = "Admin password"
}
