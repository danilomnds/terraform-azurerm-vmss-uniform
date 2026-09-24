output "name" {
  description = "The name of the Linux Virtual Machine Scale Set."
  value       = azurerm_linux_virtual_machine_scale_set.vmss_uniform.name
}

output "id" {
  description = "The resource ID of the Linux Virtual Machine Scale Set."
  value       = azurerm_linux_virtual_machine_scale_set.vmss_uniform.id
}

output "unique_id" {
  description = "The unique ID of the Linux Virtual Machine Scale Set."
  value       = azurerm_linux_virtual_machine_scale_set.vmss_uniform.unique_id
}

output "identity" {
  description = "The managed identity attributes exported by the Linux Virtual Machine Scale Set."
  value       = azurerm_linux_virtual_machine_scale_set.vmss_uniform.identity
}