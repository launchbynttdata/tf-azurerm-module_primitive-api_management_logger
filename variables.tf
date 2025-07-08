variable "resource_group_name" {
  type        = string
  description = "name of the resource group where the APIM exists"
  default     = null
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,50}$", var.resource_group_name))
    error_message = "The resource group name can only contain alphanumeric characters and dashes and must be between 1 and 50 characters long."
  }
}

variable "api_management_name" {
  type        = string
  description = "name of the APIM in which this logger will de deployed"
  default     = null
  validation {
    condition     = can(regex("^[a-zA-Z0-9-]{1,50}$", var.api_management_name))
    error_message = "The APIM name can only contain alphanumeric characters and dashes and must be between 1 and 50 characters long."
  }
}

variable "resource_id" {
  type        = string
  description = "Can be the ARM Resource ID of Application Insights or Event Hub to push data to"
  default     = null
  validation {
    condition     = var.resource_id == null || can(regex("^[a-zA-Z0-9-:\\/_.]{1,256}$", var.resource_id))
    error_message = "The resource_id can be a URI or URL."
  }
}

variable "name" {
  type        = string
  description = "name of the logger"
  default     = null
  validation {
    condition     = var.name == null || can(regex("^[a-zA-Z0-9-]{1,50}$", var.name))
    error_message = "The logger name can only contain alphanumeric characters and dashes and must be between 1 and 50 characters long."
  }
}

variable "buffered" {
  type        = bool
  description = "whether records should be buffered in the Logger prior to publishing"
  default     = true
}

variable "description" {
  type        = string
  description = "description of the logger"
  default     = null
}

variable "application_insights" {
  type = object({
    # support for connection_string not available until provider version 4.1
    instrumentation_key = string
  })
  description = "options for logging to application insights"
  default     = null
}

variable "eventhub" {
  type = object({
    name                             = string
    connection_string                = optional(string)
    user_assigned_identity_client_id = optional(string)
    endpoint_uri                     = optional(string)
  })
  description = "options for logging to event hub"
  default     = null
  validation {
    condition = var.eventhub == null || (
      try(var.eventhub.connection_string != null || var.eventhub.endpoint_uri != null, false)
    )
    error_message = "Either connection_string or endpoint_uri must be provided for event hub logging"
  }
  validation {
    condition = var.eventhub == null || try(var.eventhub.endpoint_uri == null, false) || (
      try(var.eventhub.user_assigned_identity_client_id != null, false)
    )
    error_message = "user_assigned_identity_client_id must be provided when endpoint_uri is provided for event hub logging"
  }
}
