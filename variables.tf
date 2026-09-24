variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "instances" {
  type    = number
  default = 0
}

variable "sku" {
  type = string
}

variable "network_interface" {
  type = list(object({
    name           = string
    auxiliary_mode = optional(string)
    auxiliary_sku  = optional(string)
    ip_configuration = list(object({
      name                                         = string
      application_gateway_backend_address_pool_ids = optional(list(string))
      application_security_group_ids               = optional(list(string))
      load_balancer_backend_address_pool_ids       = optional(list(string))
      load_balancer_inbound_nat_rules_ids          = optional(list(string))
      primary                                      = optional(bool)
      public_ip_address = optional(object({
        name                    = string
        domain_name_label       = optional(string)
        idle_timeout_in_minutes = optional(number)
        ip_tag = optional(list(object({
          tag  = string
          type = string
        })), [])
        public_ip_prefix_id = optional(string)
        version             = optional(string)
      }))
      subnet_id = optional(string)
      version   = optional(string)
    }))
    dns_servers                    = optional(list(string))
    accelerated_networking_enabled = optional(bool)
    ip_forwarding_enabled          = optional(bool)
    network_security_group_id      = optional(string)
    primary                        = optional(bool)
  }))

  validation {
    condition     = length(var.network_interface) > 0 && alltrue([for nic in var.network_interface : length(nic.ip_configuration) > 0])
    error_message = "At least one network interface with at least one IP configuration must be provided."
  }
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
    diff_disk_settings = optional(object({
      option    = string
      placement = optional(string)
    }))
    disk_size_gb                     = optional(number)
    disk_encryption_set_id           = optional(string)
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    write_accelerator_enabled        = optional(bool)
  })
}

variable "additional_capabilities" {
  type = object({
    ultra_ssd_enabled = optional(bool, false)
  })
  default = null
}

variable "admin_password" {
  type      = string
  default   = null
  sensitive = true
}

variable "admin_ssh_key" {
  type = list(object({
    public_key = string
    username   = string
  }))
  default = null
}

variable "automatic_os_upgrade_policy" {
  type = object({
    automatic_rollback_enabled   = bool
    automatic_os_upgrade_enabled = bool
  })
  default = {
    automatic_rollback_enabled   = true
    automatic_os_upgrade_enabled = false
  }
}

variable "automatic_instance_repair" {
  type = object({
    enabled      = bool
    grace_period = optional(string)
    action       = optional(string)
  })
  default = null
}

variable "boot_diagnostics" {
  type = object({
    storage_account_uri = optional(string)
  })
  default = null
}

variable "capacity_reservation_group_id" {
  type    = string
  default = null
}

variable "computer_name_prefix" {
  type    = string
  default = null
}

variable "custom_data" {
  type    = string
  default = null
}

variable "data_disk" {
  type = list(object({
    name                      = optional(string)
    caching                   = string
    create_option             = optional(string)
    disk_size_gb              = number
    lun                       = number
    storage_account_type      = string
    disk_encryption_set_id    = optional(string)
    disk_iops_read_write      = optional(number)
    disk_mbps_read_write      = optional(number)
    write_accelerator_enabled = optional(bool)
  }))
  default = null
}

variable "disable_password_authentication" {
  type    = bool
  default = true
}

variable "do_not_run_extensions_on_overprovisioned_machines" {
  type    = bool
  default = false
}

variable "edge_zone" {
  type    = string
  default = null
}

variable "encryption_at_host_enabled" {
  type    = bool
  default = null
}

variable "extension" {
  type = list(object({
    name                       = string
    publisher                  = string
    type                       = string
    type_handler_version       = string
    auto_upgrade_minor_version = optional(bool)
    automatic_upgrade_enabled  = optional(bool)
    force_update_tag           = optional(string)
    protected_settings         = optional(string)
    protected_settings_from_key_vault = optional(object({
      secret_url      = string
      source_vault_id = string
    }))
    provision_after_extensions = optional(list(string))
    settings                   = optional(string)
  }))
  default = null
}

variable "extension_operations_enabled" {
  type    = bool
  default = true
}

variable "extensions_time_budget" {
  type    = string
  default = null
}

variable "eviction_policy" {
  type    = string
  default = null
}

variable "gallery_application" {
  type = list(object({
    version_id             = string
    configuration_blob_uri = optional(string)
    order                  = optional(number)
    tag                    = optional(string)
  }))
  default = null
}

variable "health_probe_id" {
  type    = string
  default = null
}

variable "host_group_id" {
  type    = string
  default = null
}

variable "identity" {
  description = "Specifies the type of Managed Service Identity that should be configured on this Linux Virtual Machine Scale Set."
  type = object({
    type         = string
    identity_ids = optional(list(string))
  })
  default = null
}

variable "max_bid_price" {
  type    = number
  default = null
}

variable "overprovision" {
  type    = bool
  default = true
}

variable "plan" {
  type = object({
    name      = string
    publisher = string
    product   = string
  })
  default = null
}

variable "platform_fault_domain_count" {
  type    = number
  default = null
}

variable "priority" {
  type    = string
  default = "Regular"
}

variable "provision_vm_agent" {
  type    = bool
  default = true
}

variable "proximity_placement_group_id" {
  type    = string
  default = null
}

variable "rolling_upgrade_policy" {
  type = object({
    cross_zone_upgrades_enabled             = optional(bool)
    max_batch_instance_percent              = number
    max_unhealthy_instance_percent          = number
    max_unhealthy_upgraded_instance_percent = number
    pause_time_between_batches              = string
    prioritize_unhealthy_instances_enabled  = optional(bool)
    maximum_surge_instances_enabled         = optional(bool)
  })
  default = null
}

variable "scale_in" {
  type = object({
    rule                   = optional(string)
    force_deletion_enabled = optional(bool)
  })
  default = null
}

variable "secret" {
  type = list(object({
    certificate = list(object({
      url = string
    }))
    key_vault_id = string
  }))
  default = null
}

variable "secure_boot_enabled" {
  type    = bool
  default = null
}

variable "single_placement_group" {
  type    = bool
  default = true
}

variable "source_image_id" {
  type    = string
  default = null
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = null
}

variable "spot_restore" {
  type = object({
    enabled = optional(bool)
    timeout = optional(string)
  })
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "termination_notification" {
  type = object({
    enabled = bool
    timeout = optional(string)
  })
  default = null
}

variable "upgrade_mode" {
  type    = string
  default = "Manual"
}

variable "user_data" {
  type    = string
  default = null
}

variable "vtpm_enabled" {
  type    = bool
  default = null
}

variable "resilient_vm_creation_enabled" {
  description = "Specifies whether resilient VM creation is enabled."
  type        = bool
  default     = false
}

variable "resilient_vm_deletion_enabled" {
  description = "Specifies whether resilient VM deletion is enabled."
  type        = bool
  default     = false
}

variable "timeouts" {
  description = "Optional operation timeouts for creating, reading, updating, and deleting the VM Scale Set."
  type = object({
    create = optional(string)
    read   = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}

variable "zone_balance" {
  type    = bool
  default = false
}


variable "zones" {
  type    = list(string)
  default = ["1", "2", "3"]
}

variable "azure_ad_groups" {
  type    = list(string)
  default = []
}