resource "azurerm_linux_virtual_machine_scale_set" "vmss_uniform" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  admin_username      = var.admin_username
  instances           = var.instances
  sku                 = var.sku
  # first network interface
  network_interface {
    name = var.network_interface[0].name
    # first ip configuration
    ip_configuration {
      name                                         = var.network_interface[0].ip_configuration[0].name
      application_gateway_backend_address_pool_ids = lookup(var.network_interface[0].ip_configuration[0], "application_gateway_backend_address_pool_ids", null)
      application_security_group_ids               = lookup(var.network_interface[0].ip_configuration[0], "application_security_group_ids", null)
      load_balancer_backend_address_pool_ids       = lookup(var.network_interface[0].ip_configuration[0], "load_balancer_backend_address_pool_ids", null)
      load_balancer_inbound_nat_rules_ids          = lookup(var.network_interface[0].ip_configuration[0], "load_balancer_inbound_nat_rules_ids", null)
      primary                                      = lookup(var.network_interface[0].ip_configuration[0], "primary", null)      
      dynamic "public_ip_address" {
        for_each = var.network_interface[0].ip_configuration[0].public_ip_address != null ? [var.network_interface[0].ip_configuration[0].public_ip_address] : []
        content {
          name                    = public_ip_address.value.name
          domain_name_label       = lookup(public_ip_address.value, "domain_name_label", null)
          idle_timeout_in_minutes = lookup(public_ip_address.value, "idle_timeout_in_minutes", null)
          dynamic "ip_tag" {
            for_each = public_ip_address.value.ip_tag != null ? [public_ip_address.value.ip_tag] : []
            content {
              tag  = ip_tag.value.tag
              type = ip_tag.value.type
            }
          }
          public_ip_prefix_id = lookup(public_ip_address.value, "public_ip_prefix_id", null)
          version             = lookup(public_ip_address.value, "version", null)
        }
      }
      subnet_id = lookup(var.network_interface[0].ip_configuration[0], "subnet_id", null)
      version   = lookup(var.network_interface[0].ip_configuration[0], "version", null)
    }
    # optional additional ip configuration
    dynamic "ip_configuration" {
      for_each = length(var.network_interface[0].ip_configuration) > 1 ? slice(var.network_interface[0].ip_configuration, 1, length(var.network_interface[0].ip_configuration)) : []
      content {
        name                                         = ip_configuration.value.name
        application_gateway_backend_address_pool_ids = lookup(ip_configuration.value, "application_gateway_backend_address_pool_ids", null)
        application_security_group_ids               = lookup(ip_configuration.value, "application_security_group_ids", null)
        load_balancer_backend_address_pool_ids       = lookup(ip_configuration.value, "load_balancer_backend_address_pool_ids", null)
        load_balancer_inbound_nat_rules_ids          = lookup(ip_configuration.value, "load_balancer_inbound_nat_rules_ids", null)
        primary                                      = lookup(ip_configuration.value, "primary", null)        
        dynamic "public_ip_address" {
          for_each = ip_configuration.value.public_ip_address != null ? [ip_configuration.value.public_ip_address] : []
          content {
            name                    = public_ip_address.value.name
            domain_name_label       = lookup(public_ip_address.value, "domain_name_label", null)
            idle_timeout_in_minutes = lookup(public_ip_address.value, "idle_timeout_in_minutes", null)
            dynamic "ip_tag" {
              for_each = public_ip_address.value.ip_tag != null ? [public_ip_address.value.ip_tag] : []
              content {
                tag  = ip_tag.value.tag
                type = ip_tag.value.type
              }
            }
            public_ip_prefix_id = lookup(public_ip_address.value, "public_ip_prefix_id", null)
            version             = lookup(public_ip_address.value, "version", null)
          }
        }
        subnet_id = lookup(var.network_interface[0].ip_configuration[0], "subnet_id", null)
        version   = lookup(var.network_interface[0].ip_configuration[0], "version", null)
      }
    }
    dns_servers                   = lookup(var.network_interface[0], "dns_servers", null)
    enable_accelerated_networking = lookup(var.network_interface[0], "enable_accelerated_networking", null)
    enable_ip_forwarding          = lookup(var.network_interface[0], "enable_ip_forwarding", null)
    network_security_group_id     = lookup(var.network_interface[0], "network_security_group_id", null)
    primary                       = lookup(var.network_interface[0], "primary", null)
  }
  # optional additional network interface
  dynamic "network_interface" {
    for_each = length(var.network_interface) > 1 ? slice(var.network_interface, 1, length(var.network_interface)) : []
    content {
    name = network_interface.value.name    
    dynamic "ip_configuration" {
      for_each = length(var.network_interface) > 1 ? [] : network_interface.ip_configuration
      content {
        name                                         = ip_configuration.value.name
        application_gateway_backend_address_pool_ids = lookup(ip_configuration.value, "application_gateway_backend_address_pool_ids", null)
        application_security_group_ids               = lookup(ip_configuration.value, "application_security_group_ids", null)
        load_balancer_backend_address_pool_ids       = lookup(ip_configuration.value, "load_balancer_backend_address_pool_ids", null)
        load_balancer_inbound_nat_rules_ids          = lookup(ip_configuration.value, "load_balancer_inbound_nat_rules_ids", null)
        primary                                      = lookup(ip_configuration.value, "primary", null)
        dynamic "public_ip_address" {
          for_each = ip_configuration.value.public_ip_address != null ? [ip_configuration.value.public_ip_address] : []
          content {
            name                    = public_ip_address.value.name
            domain_name_label       = lookup(public_ip_address.value, "domain_name_label", null)
            idle_timeout_in_minutes = lookup(public_ip_address.value, "idle_timeout_in_minutes", null)
            dynamic "ip_tag" {
              for_each = public_ip_address.value.ip_tag != null ? [public_ip_address.value.ip_tag] : []
              content {
                tag  = ip_tag.value.tag
                type = ip_tag.value.type
              }
            }
            public_ip_prefix_id = lookup(public_ip_address.value, "public_ip_prefix_id", null)
            version             = lookup(public_ip_address.value, "version", null)
          }
        }
        subnet_id = lookup(var.network_interface[0].ip_configuration[0], "subnet_id", null)
        version   = lookup(var.network_interface[0].ip_configuration[0], "version", null)
      }
    }
    dns_servers                   = lookup(var.network_interface[0], "dns_servers", null)
    enable_accelerated_networking = lookup(var.network_interface[0], "enable_accelerated_networking", null)
    enable_ip_forwarding          = lookup(var.network_interface[0], "enable_ip_forwarding", null)
    network_security_group_id     = lookup(var.network_interface[0], "network_security_group_id", null)
    primary                       = lookup(var.network_interface[0], "primary", null)
    }
  }
  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
    dynamic "diff_disk_settings" {
      for_each = var.os_disk.diff_disk_settings != null ? [var.os_disk.diff_disk_settings] : []
      content {
        option    = diff_disk_settings.value.option
        placement = lookup(diff_disk_settings.value, "placement", null)
      }
    }
    disk_size_gb                     = lookup(var.os_disk, "disk_size_gb", null)
    secure_vm_disk_encryption_set_id = lookup(var.os_disk, "secure_vm_disk_encryption_set_id", null)
    security_encryption_type         = lookup(var.os_disk, "security_encryption_type", null)
    write_accelerator_enabled        = lookup(var.os_disk, "write_accelerator_enabled", null)
  }
  dynamic "additional_capabilities" {
    for_each = var.additional_capabilities != null ? [var.additional_capabilities] : []
    content {
      ultra_ssd_enabled = additional_capabilities.value.ultra_ssd_enabled
    }
  }
  admin_password = var.admin_password
  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_key != null ? var.admin_ssh_key : []
    content {
      public_key = admin_ssh_key.value.public_key
      username   = admin_ssh_key.value.username
    }
  }
  dynamic "automatic_os_upgrade_policy" {
    for_each = var.automatic_os_upgrade_policy != null ? [var.automatic_os_upgrade_policy] : []
    content {
      disable_automatic_rollback  = automatic_os_upgrade_policy.value.disable_automatic_rollback
      enable_automatic_os_upgrade = automatic_os_upgrade_policy.value.enable_automatic_os_upgrade
    }
  }
  dynamic "automatic_instance_repair" {
    for_each = var.automatic_instance_repair != null ? [var.automatic_instance_repair] : []
    content {
      enabled      = automatic_instance_repair.value.enabled
      grace_period = lookup(automatic_instance_repair.value, "grace_period", null)
      #action = lookup(automatic_instance_repair.value, "action", null)    
    }
  }
  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics != null ? [var.boot_diagnostics] : []
    content {
      storage_account_uri = lookup(boot_diagnostics.value, "storage_account_uri", null)
    }
  }
  capacity_reservation_group_id = var.capacity_reservation_group_id
  computer_name_prefix          = var.computer_name_prefix
  custom_data                   = var.custom_data
  dynamic "data_disk" {
    for_each = var.data_disk != null ? var.data_disk : []
    content {
      name                           = lookup(data_disk.value, "name", null)
      caching                        = data_disk.value.caching
      create_option                  = lookup(data_disk.value, "create_option", null)
      disk_size_gb                   = lookup(data_disk.value, "disk_size_gb", null)
      lun                            = data_disk.value.lun
      storage_account_type           = lookup(data_disk.value, "storage_account_type", null)
      disk_encryption_set_id         = lookup(data_disk.value, "disk_encryption_set_id", null)
      ultra_ssd_disk_iops_read_write = lookup(data_disk.value, "ultra_ssd_disk_iops_read_write", null)
      ultra_ssd_disk_mbps_read_write = lookup(data_disk.value, "ultra_ssd_disk_mbps_read_write", null)
      write_accelerator_enabled      = lookup(data_disk.value, "write_accelerator_enabled", null)
    }
  }
  disable_password_authentication                   = var.disable_password_authentication
  do_not_run_extensions_on_overprovisioned_machines = var.do_not_run_extensions_on_overprovisioned_machines
  edge_zone                                         = var.edge_zone
  encryption_at_host_enabled                        = var.encryption_at_host_enabled
  dynamic "extension" {
    for_each = var.extension != null ? var.extension : []
    content {
      name                       = extension.value.name
      publisher                  = extension.value.publisher
      type                       = extension.value.type
      type_handler_version       = lookup(extension.value, "type_handler_version", null)
      auto_upgrade_minor_version = lookup(extension.value, "auto_upgrade_minor_version", null)
      automatic_upgrade_enabled  = lookup(extension.value, "automatic_upgrade_enabled", null)
      force_update_tag           = lookup(extension.value, "force_update_tag", null)
      protected_settings         = lookup(extension.value, "protected_settings", null)
      dynamic "protected_settings_from_key_vault" {
        for_each = extension.value.protected_settings_from_key_vault != null ? [extension.value.protected_settings_from_key_vault] : []
        content {
          secret_url      = protected_settings_from_key_vault.value.secret_url
          source_vault_id = protected_settings_from_key_vault.value.source_vault_id
        }
      }
      provision_after_extensions = lookup(extension.value, "provision_after_extensions", null)
      settings                   = lookup(extension.value, "settings", null)
    }
  }
  extension_operations_enabled = var.extension_operations_enabled
  extensions_time_budget       = var.extensions_time_budget
  eviction_policy              = var.eviction_policy
  dynamic "gallery_application" {
    for_each = var.gallery_application != null ? var.gallery_application : []
    content {
      version_id             = gallery_application.value.version_id
      configuration_blob_uri = lookup(gallery_application.value, "configuration_blob_uri", null)
      order                  = lookup(gallery_application.value, "order", null)
      tag                    = lookup(gallery_application.value, "tag", null)
    }
  }
  health_probe_id = var.health_probe_id
  host_group_id   = var.host_group_id
  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }
  max_bid_price = var.max_bid_price
  overprovision = var.overprovision
  dynamic "plan" {
    for_each = var.plan != null ? [var.plan] : []
    content {
      name      = plan.value.name
      publisher = plan.value.publisher
      product   = plan.value.product
    }
  }
  platform_fault_domain_count  = var.platform_fault_domain_count
  priority                     = var.priority
  provision_vm_agent           = var.provision_vm_agent
  proximity_placement_group_id = var.proximity_placement_group_id
  dynamic "rolling_upgrade_policy" {
    for_each = var.rolling_upgrade_policy != null ? [var.rolling_upgrade_policy] : []
    content {
      cross_zone_upgrades_enabled             = lookup(rolling_upgrade_policy.value, "cross_zone_upgrades_enabled", null)
      max_batch_instance_percent              = rolling_upgrade_policy.value.max_batch_instance_percent
      max_unhealthy_instance_percent          = rolling_upgrade_policy.value.max_unhealthy_instance_percent
      max_unhealthy_upgraded_instance_percent = rolling_upgrade_policy.value.max_unhealthy_upgraded_instance_percent
      pause_time_between_batches              = rolling_upgrade_policy.value.pause_time_between_batches
      prioritize_unhealthy_instances_enabled  = lookup(rolling_upgrade_policy.value, "prioritize_unhealthy_instances_enabled", null)
      maximum_surge_instances_enabled         = lookup(rolling_upgrade_policy.value, "maximum_surge_instances_enabled", null)
    }
  }

  dynamic "scale_in" {
    for_each = var.scale_in != null ? [var.scale_in] : []
    content {
      rule                   = lookup(scale_in.value, "rule", null)
      force_deletion_enabled = lookup(scale_in.value, "force_deletion_enabled", null)
    }
  }
  dynamic "secret" {
    for_each = var.secret != null ? var.secret : []
    content {
      dynamic "certificate" {
        for_each = secret.value.certificate != null ? [secret.value.certificate] : []
        content {
          url = certificate.value.url
        }
      }
      key_vault_id = secret.value.key_vault_id
    }
  }
  secure_boot_enabled    = var.secure_boot_enabled
  single_placement_group = var.single_placement_group
  source_image_id        = var.source_image_id
  dynamic "source_image_reference" {
    for_each = var.source_image_reference != null ? [var.source_image_reference] : []
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }
  dynamic "spot_restore" {
    for_each = var.spot_restore != null ? [var.spot_restore] : []
    content {
      enabled = lookup(spot_restore.value, "enabled", null)
      timeout = lookup(spot_restore.value, "timeout", null)
    }
  }
  tags = local.tags
  dynamic "termination_notification" {
    for_each = var.termination_notification != null ? [var.termination_notification] : []
    content {
      enabled = lookup(termination_notification.value, "enabled", null)
      timeout = lookup(termination_notification.value, "timeout", null)
    }
  }
  upgrade_mode = var.upgrade_mode
  user_data    = var.user_data
  vtpm_enabled = var.vtpm_enabled
  zone_balance = var.zone_balance
  lifecycle {
    ignore_changes = [
      tags["create_date"]
    ]
  }
}

resource "azurerm_role_assignment" "vmss_uniform_reader" {
  depends_on = [
    azurerm_linux_virtual_machine_scale_set.vmss_uniform
  ]
  for_each = {
    for group in var.azure_ad_groups : group => group
  }
  scope                = azurerm_linux_virtual_machine_scale_set.vmss_uniform
  role_definition_name = "Reader"
  principal_id         = each.value
}