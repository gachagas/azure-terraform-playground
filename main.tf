# Configure the Azure provider

provider "azurerm" {
  features {}
}


module "my_nsg" {
  source         = "./modules/network_security_group"
  admin_password = var.admin_password
}

# module "my_vms" {
#   source         = "./modules/two_vms"
#   admin_password = var.admin_password
# }

# output "vm1_public_ip" {
#   value = module.my_vms.public_ip_vm1
# }

# output "vm2_public_ip" {
#   value = module.my_vms.public_ip_vm2
# }