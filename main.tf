resource "azurerm_api_management_logger" "logger" {
  name                = var.name
  resource_group_name = var.resource_group_name
  api_management_name = var.api_management_name

  buffered    = var.buffered
  description = var.description

  dynamic "application_insights" {
    for_each = var.application_insights != null ? [var.application_insights] : []
    content {
      instrumentation_key = var.application_insights.instrumentation_key
    }
  }

  dynamic "eventhub" {
    for_each = var.eventhub != null ? [var.eventhub] : []
    content {
      name                             = var.eventhub.name
      connection_string                = var.eventhub.connection_string
      user_assigned_identity_client_id = var.eventhub.user_assigned_identity_client_id
      endpoint_uri                     = var.eventhub.endpoint_uri
    }
  }
}
