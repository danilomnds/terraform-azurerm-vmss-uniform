# Module - Azure Linux Virtual Machine Scale Set
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module developed to standardize the linux virtual machine scale set creation.

## Compatibility Matrix

| Module Version | Terraform Version | AzureRM Version |
|----------------|-------------------| --------------- |
| v1.0.0         | v1.9.5            | 4.0.0          |

## Use case

```hcl
module "vmss-prd-devops-002" {
  #source                         = "https://github.com/danilomnds/terraform-azurerm-vmss-uniform?ref=v1.0.0"
  source                          = "git::https://github.com/danilomnds/terraform-azurerm-vmss-uniform"
  name                            = "vmss-prd-devops-002"
  location                        = "brazilsouth"
  resource_group_name             = "rg-br-shared-devops"
  disable_password_authentication = false
  admin_username                  = var.LINUX_USERNAME
  admin_password                  = var.LINUX_PASSWORD
  instances                       = 1
  sku                             = "Standard_D2ads_v5"
  zones                           = [1, 2, 3]
  network_interface = [{
    name    = "vmss-prd-devops-002-nic"
    primary = true
    ip_configuration = [{
      name      = "internal"
      primary   = true
      subnet_id = ""
    }]
  }]
  os_disk = {
    caching              = "none"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 64
  }
  custom_data = filebase64("./startup.sh")
  extension = [{
    name                 = "Microsoft.Azure.DevOps.Pipelines.Agent"
    publisher            = "Microsoft.VisualStudio.Services"
    type                 = "TeamServicesAgentLinux"
    type_handler_version = "1.23"
    },
    {
      name                 = "CustomScript"
      publisher            = "Microsoft.Azure.Extensions"
      type                 = "CustomScript"
      type_handler_version = "2.0"
  }]
  source_image_reference = {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "88-gen2"
    version   = "latest"
  }
  tags = {
    "key1" = "value1"
    "key2" = "value2"
  }
}
output "name" {
  value = module.vmss-prd-devops-002.name
}
output "id" {
  value = module.vmss-prd-devops-002.id
}
```

## Input variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | eventhub namespace name | `string` | n/a | `Yes` |
| location | azure region | `string` | n/a | `Yes` |
| resource_group_name | resource group where the ACR will be placed | `string` | n/a | `Yes` |
| admin_username | The username of the local administrator on each Virtual Machine Scale Set instance | `string` | n/a | `Yes` |
| instances | The number of Virtual Machines in the Scale Set | `number` | `0` | No |
| sku | The Virtual Machine SKU for the Scale Set, such as Standard_F2 | `string` | n/a | `Yes` |
| network_interface | One or more network_interface blocks as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | `Yes` |
| os_disk | An os_disk block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | `Yes` |
| additional_capabilities | An additional_capabilities block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | No |
| admin_password | The Password which should be used for the local-administrator on this Virtual Machine | `string` | n/a | No |
| admin_ssh_key | One or more admin_ssh_key blocks as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `list(object({}))` | n/a | No |
| automatic_os_upgrade_policy | An automatic_os_upgrade_policy block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | No |
| automatic_instance_repair | An automatic_instance_repair block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | No |
| boot_diagnostics | A boot_diagnostics block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | No |
| capacity_reservation_group_id |  Specifies the ID of the Capacity Reservation Group which the Virtual Machine Scale Set should be allocated to | `string` | n/a | No |
| computer_name_prefix | The prefix which should be used for the name of the Virtual Machines in this Scale Set | `string` | n/a | No |
| custom_data | The Base64-Encoded Custom Data which should be used for this Virtual Machine Scale Set | `string` | n/a | No |
| data_disk | One or more data_disk blocks as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `list(object({}))` | n/a | No |
| disable_password_authentication | Should Password Authentication be disabled on this Virtual Machine Scale Set | `bool` | `true` | No |
| do_not_run_extensions_on_overprovisioned_machines | Should Virtual Machine Extensions be run on Overprovisioned Virtual Machines in the Scale Set | `bool` | `false` | No |
| edge_zone | Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine Scale Set should exist | `string` | n/a | No |
| encryption_at_host_enabled | Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host | `bool` | n/a | No |
| extension | One or more extension blocks as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `list(object({}))` | n/a | No |
| extension_operations_enabled | Should extension operations be allowed on the Virtual Machine Scale Set | `bool` | `true` | No |
| extensions_time_budget | Specifies the duration allocated for all extensions to start | `string` | n/a | No |
| eviction_policy | Specifies the eviction policy for Virtual Machines in this Scale Set | `string` | n/a | No |
| gallery_application | One or more gallery_application blocks as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `list(object({}))` | n/a | No |
| health_probe_id | The ID of a Load Balancer Probe which should be used to determine the health of an instance | `string` | n/a | No |
| host_group_id | Specifies the ID of the dedicated host group that the virtual machine scale set resides in | `string` | n/a | No |
| identity | block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | No |
| max_bid_price | The maximum price you're willing to pay for each Virtual Machine in this Scale Set, in US Dollars; which must be greater than the current spot price | `string` | n/a | No |
| overprovision | Should Azure over-provision Virtual Machines in this Scale Set | `bool` | `true` | No |
| plan | A plan block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | No |
| platform_fault_domain_count | Specifies the number of fault domains that are used by this Linux Virtual Machine Scale Set | `number` | n/a | No |
| priority | The Priority of this Virtual Machine Scale Set. Possible values are Regular and Spot | `string` | `Regular` | No |
| provision_vm_agent | Should the Azure VM Agent be provisioned on each Virtual Machine in the Scale Set | `bool` | `true` | No |
| proximity_placement_group_id | The ID of the Proximity Placement Group in which the Virtual Machine Scale Set should be assigned to | `string` | n/a | No |
| rolling_upgrade_policy | A rolling_upgrade_policy block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | No |
| scale_in | A scale_in block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | No |
| secret | One or more secret blocks as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `list(object({}))` | n/a | No |
| secure_boot_enabled | Specifies whether secure boot should be enabled on the virtual machine | `bool` | n/a | No |
| single_placement_group | Should this Virtual Machine Scale Set be limited to a Single Placement Group, which means the number of instances will be capped at 100 Virtual Machines | `bool` | `true` | No |
| source_image_id | The ID of an Image which each Virtual Machine in this Scale Set should be based on | `string` | n/a | No |
| source_image_reference | A source_image_reference block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | No |
| spot_restore | A spot_restore block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | No |
| tags | tags for the resource | `map(string)` | `{}` | No |
| termination_notification | A termination_notification block as defined in the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | `object({})` | n/a | No |
| upgrade_mode | Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances | `string` | `manual` | No |
| user_data | The Base64-Encoded User Data which should be used for this Virtual Machine Scale Set | `string` | `manual` | No |
| vtpm_enabled | Specifies whether vTPM should be enabled on the virtual machine | `bool` | n/a | No |
| zone_balance | Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones | `bool` | `false` | No |
| zones | Specifies a list of Availability Zones in which this Linux Virtual Machine Scale Set should be located | `list(string)` | `["1","2","3"]` | No |
| azure_ad_groups | list of azure AD groups that will be granted the Reader role  | `list` | `[]` | No |

## Output variables

| Name | Description |
|------|-------------|
| name | vmss name |
| id | vmss id |

## Documentation

Terraform Linux Virtual Machine Scale Set: <br>
[https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set)<br>
