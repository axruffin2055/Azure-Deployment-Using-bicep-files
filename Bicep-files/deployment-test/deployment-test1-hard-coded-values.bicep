/*
 This Bicep file is used to deploy a storage account and an app service plan with an app service application in Azure. 
 The resources are defined with hard-coded values for their properties, such as names, locations, and SKU types.
*/

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  // Storage account name must be unique and contain only lower-case letters.
  name: 'dfsdfdsafdfdf'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  //Click CTRL + SPACE to see the available properties for the storage account.  
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: 'robotic-starter-plan'
  location: 'eastus'
  sku: {
    name: 'F1'
    tier: 'Free'
 //Click CTRL + SPACE to see the available properties for the app service plan.
 }
}

resource appServiceApp 'Microsoft.Web/sites@2025-03-01' = {
  // This is the name of the app service. It must be unique across Azure.
  name: 'dfsdfdsafdfdf'
  location: 'eastus'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  //Click CTRL + SPACE to see the available properties for the app service.  
  }
}

