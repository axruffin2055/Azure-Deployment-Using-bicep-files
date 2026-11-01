/*
  This Bicep file is used to deploy a storage account and an app service plan with an app service application in Azure. 
  We are using parameters and variables to define the properties of the resources, allowing for more flexibility and reusability of the Bicep file. 
  Use the parameters to prompt the user for input values during deployment.
  And use variables to define values that can be reused throughout the Bicep file.
  
*/

@description('The location where the resources will be deployed.')
param location string = resourceGroup().location

@description('The name of the storage account to be created. It must be unique across Azure.')
param storageAccountName string = 'roboticstarterstorage${uniqueString(resourceGroup().id)}'

@description('The name of the app service to be created. It must be unique across Azure.')
param appServiceAppName string = 'roboticstarterapp${uniqueString(resourceGroup().id)}'

@description('The name of the app service plan to be created.')
var appServicePlanName string = 'robotic-starter-plan'

//The sku names for the storage account and app service plan are determined based on the environment type parameter.
@allowed([
  'test'
  'prod'
])
param environmenttype string 

//If the environment type is 'prod', use Standard_GRS for the storage account SKU, otherwise use Standard_LRS.
var storageAccountSkuName = (environmenttype == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

//If the environment type is 'prod', use P1v2 for the app service plan SKU, otherwise use F1.
var appServicePlanSkuName = (environmenttype == 'prod') ? 'P1v2' : 'F1'


resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  // Storage account name must be unique and contain only lower-case letters.
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  //Click CTRL + SPACE to see the available properties for the storage account.  
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
    tier: 'Free'
 //Click CTRL + SPACE to see the available properties for the app service plan.
 }
}

resource appServiceApp 'Microsoft.Web/sites@2025-03-01' = {
  // This is the name of the app service. It must be unique across Azure.
  name: appServiceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  //Click CTRL + SPACE to see the available properties for the app service.  
  }
}

// Output the hostname of the app service application after deployment.
output appServiceAppHostname string = appServiceApp.properties.defaultHostName
