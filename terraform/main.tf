resource "azurerm_resource_group" "redis" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_managed_redis" "chat_history" {
  name                  = var.redis_name
  resource_group_name   = azurerm_resource_group.redis.name
  location              = azurerm_resource_group.redis.location
  sku_name              = var.redis_sku_name
  public_network_access = "Disabled"

  default_database {
    access_keys_authentication_enabled          = false
    client_protocol                             = "Encrypted"
    eviction_policy                             = "NoEviction"
    persistence_redis_database_backup_frequency = "1h"
  }
}
