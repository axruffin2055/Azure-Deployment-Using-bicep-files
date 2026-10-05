@description("This is a storage account template that has parameters")

param storageAccountName string
param location string
param skuType string

resource storageAccount
'Microsoft.Storage/storageAccounts@2024-01-01' =
{
  name: storageAccountName
  location: location
  sku: {
    name: skuType
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: 'true'
  }
}
