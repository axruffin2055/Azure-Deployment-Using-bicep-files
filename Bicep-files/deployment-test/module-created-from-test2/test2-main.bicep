@description('The location where the resources will be deployed.')
param location string = resourceGroup().location

@description('The name of the storage account to be created. It must be unique across Azure.')
param storageAccountName string = 'roboticstarterstorage${uniqueString(resourceGroup().id)}'

@description('The name of the app service to be created. It must be unique across Azure.')
param appServiceAppName string = 'roboticstarterapp${uniqueString(resourceGroup().id)}'


//The sku names for the storage account and app service plan are determined based on the environment type parameter.
@allowed([
  'test'
  'prod'
])
param environmenttype string 

//If the environment type is 'prod', use Standard_GRS for the storage account SKU, otherwise use Standard_LRS.
var storageAccountSkuName = (environmenttype == 'prod') ? 'Standard_GRS' : 'Standard_LRS'


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

//The app service module is defined in a separate Bicep file (appService.bicep) and is referenced here. 
//The parameters from appService.bicep are passed to the appService.bicep module.
module appServiceModule 'appService.bicep' = {
  name: 'appServiceModule'
  params: {
    location: location
    appServiceAppName: appServiceAppName
    environmenttype: environmenttype
  
  }
}
//We get added information after appService was deployed the first time. otherwise app.outputs will be empty.
output appServiceAppHostname string = app.outputs.appServiceAppHostname
