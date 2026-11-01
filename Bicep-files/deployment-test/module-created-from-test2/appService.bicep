/*
  We refactored the app service and app service plan resources into a separate module (appService.bicep)
  to make the main Bicep file (test2-main.bicep) cleaner and more organized.
  All parameters and variables related to the app service and app service plan are now defined 
  in the appService.bicep module.
*/

//test2-main.bicep already has default values for the parameters defined in the module.
param location string
param appServiceAppName string 

@allowed([
  'test'
  'prod'
])
param environmenttype string 

var appServicePlanName string = 'robotic-starter-plan'
var appServicePlanSkuName = (environmenttype == 'prod') ? 'P1v2' : 'F1'


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

output appServiceAppHostname string = appServiceApp.properties.defaultHostName
