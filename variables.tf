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
    name = string
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
        ip_tag = optional(object({
          tag  = string
          type = string
        }))
        public_ip_prefix_id = optional(string)
        version             = optional(string)
      }))
      subnet_id = optional(string)
      version   = optional(string)
    }))
    dns_servers                   = optional(list(string))
    enable_accelerated_networking = optional(bool)
    enable_ip_forwarding          = optional(bool)
    network_security_group_id     = optional(string)
    primary                       = optional(bool)
  }))
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
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    write_accelerator_enabled        = optional(bool)
  })
}

variable "additional_capabilities" {
  type = object({
    ultra_ssd_enabled = bool
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
    disable_automatic_rollback  = bool
    enable_automatic_os_upgrade = bool
  })
  default = null
}

variable "automatic_instance_repair" {
  type = object({
    enabled      = bool
    grace_period = optional(number)
    action       = optional(string)
  })
  default = null
}

variable "boot_diagnostics" {
  type = object({
    storage_account_uri = string
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
    name                           = optional(string)
    caching                        = string
    create_option                  = optional(string)
    disk_size_gb                   = optional(number)
    lun                            = number
    storage_account_type           = string
    disk_encryption_set_id         = optional(string)
    ultra_ssd_disk_iops_read_write = optional(string)
    ultra_ssd_disk_mbps_read_write = optional(string)
    write_accelerator_enabled      = optional(bool)
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
    type_handler_version       = optional(string)
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
    order                  = optional(string)
    tag                    = map(string)
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
  description = "Specifies the type of Managed Service Identity that should be configured on this Container Registry"
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
  type    = string
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
    max_batch_instance_percent              = string
    max_unhealthy_instance_percent          = string
    max_unhealthy_upgraded_instance_percent = string
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
    certificate = optional(object({
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
    timeout = optional(number)
  })
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "termination_notification" {
  type = object({
    enabled = optional(bool)
    timeout = optional(number)
  })
  default = null
}

variable "upgrade_mode" {
  type    = string
  default = "manual"
}

variable "user_data" {
  type    = string
  default = null
}

variable "vtpm_enabled" {
  type    = string
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