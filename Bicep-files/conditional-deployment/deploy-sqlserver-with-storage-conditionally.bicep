@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

/* We will use user name and password and secure() will hide the values in the portal 
and in the deployment logs. It is recommended to use a Key Vault secret instead of 
a parameter for production deployments.
*/
@secure()
@description('The administrator login username for the SQL server.')
param sqlServerAdministratorLogin string

@secure()
@description('The administrator login password for the SQL server.')
param sqlServerAdministratorLoginPassword string

@description('The name and tier of the SQL database SKU.')
param sqlDatabaseSku object = {
  name: 'Standard'
  tier: 'Standard'
}

@description('The name of the environment. This must be Development or Production.')
@allowed([
  'Development'
  'Production'
])
param environmentName string = 'Development'

@description('The name of the audit storage account SKU.')
param auditStorageAccountSkuName string = 'Standard_LRS'

var sqlServerName = 'robotic-body${location}${uniqueString(resourceGroup().id)}'
var sqlDatabaseName = 'RobopartsDB'

// create a condition in a variable
var auditingEnabled = environmentName == 'Production'
var auditStorageAccountName = '${take('roboaudit${location}${uniqueString(resourceGroup().id)}', 24)}'

resource sqlServer 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2020-11-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  sku: sqlDatabaseSku
  properties: { 
    readScale: 'Disabled'
  } 
}
// Deploy conditionally
resource auditStorageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = if (auditingEnabled) {
  name: auditStorageAccountName
  location: location
  sku: {
    name: auditStorageAccountSkuName
  }
  kind: 'StorageV2'
}

// Deploy conditionally
resource sqlServerAudit 'Microsoft.Sql/servers/auditingSettings@2020-11-01-preview' = if (auditingEnabled) {
  parent: sqlServer
  name: 'default'
  properties: {
    state: 'Enabled'
    // Only define in production
    storageEndpoint: environmentName == 'Production' ? auditStorageAccount.properties.primaryEndpoints.blob : ''
    storageAccountAccessKey: environmentName == 'Production' ? listKeys(auditStorageAccount.id, auditStorageAccount.apiVersion) : ''
  }
}
