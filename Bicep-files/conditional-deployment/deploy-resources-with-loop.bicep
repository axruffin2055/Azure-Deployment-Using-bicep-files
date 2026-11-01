@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

// Use Copy Loops

@description('a list of names for all storage accounts to be created')
param storageAccountNames array = [
  'strorageaauditus'
  'stroragesaauditeurope'
  'stroragesaauditapac'
]
/* We are using the parameter storageAccountNames to create multiple storage and give name from 
   storageAccountNames to the name: storageAccountName declared in the resource storageAccountResources. 
*/
resource storageAccountResources 'Microsoft.Storage/storageAccounts@2021-01-01' = [for storageAccountName in storageAccountNames: {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
   name: 'Standard_LRS'
  }
}]


/*
We will now have unqiue storage account names in the same resource group because of the index.
robotic0<uniqueString>0
robotic1<uniqueString>1 
We can be creative and index by names instead of numbers.
roboticlab<uniqueString>lab
roboticdev<uniqueString>dev

param location string = resourceGroup().location
var totalStorageAccounts = 3
var storageAccountamount = [ for i in ro range(0, totalStorageAccounts): 'robotic${i}{uniqueString(resourceGroup().id)}${i}']

//We need to deploy multiple storage accounts with unique names.

resource storageAccountResources2 'Microsoft.Storage/storageAccounts@2021-01-01' = [for name in storageAccountamount: {
  name: name
  location: location
  kind: 'StorageV2'
  sku: {
   name: 'Standard_LRS'
  }
}]

*/
