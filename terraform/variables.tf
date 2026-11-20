variable "resource_group_name" {
  description = "Name of the Azure resource group"
  type        = string
  default     = "ai-foundary"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "francecentral"
}

variable "redis_name" {
  description = "Name of the Azure Managed Redis instance"
  type        = string
  default     = "redis-chat-history"
}

variable "redis_sku_name" {
  description = "Azure Managed Redis SKU"
  type        = string
  default     = "Balanced_B3"
}
