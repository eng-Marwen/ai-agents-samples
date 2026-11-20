output "redis_hostname" {
  description = "Hostname of the Azure Managed Redis instance"
  value       = azurerm_managed_redis.chat_history.hostname
}
