output "ubuntu_vm_ip" {
  value = module.ubuntu-vm.public_ip_address
}

output "windows_vm_ip" {
  value = module.windows_vm_custom_image.public_ip
}

output "os_username" {
  value = var.os_profile_admin_username
}
