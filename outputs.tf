output "resource_group_name" {
  value = azurerm_resource_group.pipelinerg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.pipelinesa.name
}

output "storage_container_name" {
  value = azurerm_storage_container.pipelinecontainer2.name
}