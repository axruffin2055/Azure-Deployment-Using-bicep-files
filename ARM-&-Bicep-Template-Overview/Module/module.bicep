param storageAccountName string
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2024-01-01' = {

  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
  accessTier : 'Hot'
  }
}
