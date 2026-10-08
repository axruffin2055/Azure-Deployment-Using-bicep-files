@description("module.bicep focus on resource deployment, while main.bicep file focus on resource orchestration")
@description("module.bicep can be reused across different Bicep templates. Just change the default values in 
              main.bicep param or change values at deployment")
@description("Need to deploy storage accounts to eight different environments? Well, Do not copy and paste code
             8 times. Just use the module.bicep and create a new or reuse main.bicep file to pass the correct parameters. ")

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
