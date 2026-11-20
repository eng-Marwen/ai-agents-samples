resource "azurerm_virtual_network" "redis" { # Redis VNet
  name                = "redis-vnet"
  location            = azurerm_resource_group.redis.location
  resource_group_name = azurerm_resource_group.redis.name
  address_space       = ["10.0.0.0/16"] # VNet range
}

resource "azurerm_subnet" "redis" { # Redis subnet
  name                 = "redis-subnet"
  resource_group_name  = azurerm_resource_group.redis.name
  virtual_network_name = azurerm_virtual_network.redis.name
  address_prefixes     = ["10.0.1.0/24"] # Subnet range
}

resource "azurerm_private_dns_zone" "redis" { # Redis private DNS
  name                = "privatelink.redisenterprise.cache.azure.net"
  resource_group_name = azurerm_resource_group.redis.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "redis" { # Connect DNS to the VNet
  name                  = "redis-dns-link"
  resource_group_name   = azurerm_resource_group.redis.name
  private_dns_zone_name = azurerm_private_dns_zone.redis.name
  virtual_network_id    = azurerm_virtual_network.redis.id
}

resource "azurerm_private_endpoint" "redis" { # Private Redis endpoint
  name                = "redis-private-endpoint"
  location            = azurerm_resource_group.redis.location
  resource_group_name = azurerm_resource_group.redis.name
  subnet_id           = azurerm_subnet.redis.id

  private_service_connection { # Connect to Redis
    name                           = "redis-private-connection"
    private_connection_resource_id = azurerm_managed_redis.chat_history.id
    subresource_names              = ["redisEnterprise"]
    is_manual_connection           = false
  }

  private_dns_zone_group { # Use private DNS
    name                 = "redis-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.redis.id]
  }
}
