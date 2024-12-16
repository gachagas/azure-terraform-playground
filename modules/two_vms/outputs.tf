output "public_ip_vm1" {
  value = azurerm_public_ip.public_ip[0].ip_address
}

output "public_ip_vm2" {
  value = azurerm_public_ip.public_ip[1].ip_address
}