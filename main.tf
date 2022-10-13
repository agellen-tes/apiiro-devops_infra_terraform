# Provides configuration details for Terraform
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg-1" { 
  # resource <resource type> <local name/ref in the configuration>
    name =  "agellen-euw"
    location =  "westeurope"
    tags =  {
      sub_type =  "dev_test"
      team_number =  "196"
    }
}


resource "azurerm_linux_virtual_machine_scale_set" "rs-1"{
  name = "aronVmss01"
  resource_group_name = "agellen-euw"
  location            = azurerm_resource_group.rg-1.location
  computer_name_prefix = "aronvmss0"
  sku = "Standard_D2s_v3"
  instances = 0
  admin_username = "azureuser"
  encryption_at_host_enabled = false
  overprovision = false
  platform_fault_domain_count = 1
  secure_boot_enabled = false
  single_placement_group = false

  tags = {
    "sub_type" = "dev_test"
    team_number = "196"
  }

  vtpm_enabled = false
  zones = []

  automatic_instance_repair {
    enabled = false
    grace_period = "PT30M"
  }

  boot_diagnostics {
  }

  admin_ssh_key {
    username = "azureuser"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDgFZ0b5e2XxYTr5C122ltzPrfxTTThabvnJc9ZivN6TE6wO8wEr9QeQ6q6Ge3/nrrsMgO3LSdWmLulreRIGn2oghfovR0ElLRfPIavE6OetkWymb1uY+hyNWO5O6XMbg1BTNJeZMaWVU7r+1FcEIKnJRb8pxcm02ZxW9+MZARiTrJcjjxc4Jxq9WMSe82Mq4WLPXF4Xy//BlhTDUWu2aQMnzTyCmReIPqUSHOjX7cigX1qdvNaEfMpFOKA5IklpFtYK5wquCmzNMW82BnZNOceuT3e6DCI3mGqT6hXk+ihojT77rq94hMvUV+6wctzWcAWb/MCcUsGZv4PUW8cFn04KvezyZoBWIvSaZ+5rN3fVlmeQ2raetf6WbHEcRkvzwsgS80I68+pHltP02WoVQRB7gI7km/Po6aTPE/O9XrxrnOm2mlqtGJVEKB0u02+88UPbS5YwWZXL/BGsIB1sL+7jaumRbFONHLsuUNsuAtZc/v8KVikAWPpcwXUEEFAnvU= generated-by-azure"
  }

  source_image_reference {
    publisher = "canonical"
    offer = "0001-com-ubuntu-server-focal"
    sku = "20_04-lts-gen2"
    version = "latest"
  }

  os_disk {
    storage_account_type = "Premium_LRS"
    caching = "ReadWrite"
    disk_size_gb = 30
  }

  network_interface {
    dns_servers = []
    enable_accelerated_networking = true
    name = "euw-dev-196-secarch-learnedroutes-nic01"
    network_security_group_id = "/subscriptions/9e3563c4-308c-4388-b2e5-f7c44b4ba061/resourceGroups/agellen-euw/providers/Microsoft.Network/networkSecurityGroups/basicNsgeuw-dev-196-secarch-learnedroutes-nic01"
    primary = true

    ip_configuration {
      name =  "euw-dev-196-secarch-learnedroutes-nic01-defaultIpConfiguration"
      primary = true
      subnet_id = "/subscriptions/9e3563c4-308c-4388-b2e5-f7c44b4ba061/resourceGroups/euw-dev-196-secarch-net/providers/Microsoft.Network/virtualNetworks/euw-dev-196-secarch-learnedroutes/subnets/euw-dev-196-secarch-application"
      application_gateway_backend_address_pool_ids = []
      application_security_group_ids = []
      load_balancer_backend_address_pool_ids = []
      load_balancer_inbound_nat_rules_ids = []
    }
  }
}
