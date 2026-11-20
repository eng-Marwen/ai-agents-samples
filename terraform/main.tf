resource "azurerm_resource_group" "redis" {
  name     = "ai-foundary"   # Resource group name
  location = "francecentral" # Azure region
}

resource "azurerm_managed_redis" "chat_history" {
  name                  = "redis-chat-history"                  # Redis instance name
  resource_group_name   = azurerm_resource_group.redis.name     # Resource group
  location              = azurerm_resource_group.redis.location # Azure region
  sku_name              = "Balanced_B3"                         # Redis capacity 3GB / 2vCPUs
  public_network_access = "Disabled"                            # Require private endpoint access

  default_database {
    access_keys_authentication_enabled          = false        # Require Microsoft auth
    client_protocol                             = "Encrypted"  # TLS
    eviction_policy                             = "NoEviction" # Keep history
    persistence_redis_database_backup_frequency = "1h"         # Back up history 
  }
}

output "redis_hostname" {
  value = azurerm_managed_redis.chat_history.hostname # Redis endpoint
}
