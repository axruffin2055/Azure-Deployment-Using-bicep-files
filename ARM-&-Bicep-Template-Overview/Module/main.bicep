param accountName string = 'devstore'
param location string = 'westus2'

module storageModule './module.bicep' =
{
  name: 'storageDeployment'
  params: {
    storageAccountName: accountName
    location: location
  }
}
