
/*When we this Bicep file, When we prompted the user, the storage account will 
  be deployed only if the user enters True for the deployStorageAccount parameter.
  If the user enters False, the storage account will not be deployed.
 */
@description('set to True if a storage account should be deployed')
param deployStorageAccount bool

@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-01-01' = if (deployStorageAccount) {
  name: 'robotic${uniqueString(resourceGroup().id)}'
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  } 
}
