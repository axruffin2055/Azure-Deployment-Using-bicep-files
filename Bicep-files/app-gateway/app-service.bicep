
param location string = resourceGroup().location
param appServicePlanName string = 'appserviceplan'
param appServicePlanSkuName string = 'P1v3'

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
    tier: 'PremiumV3'
 //Click CTRL + SPACE to see the available properties for the app service plan.
 }
}

param WebAppServiceName string = 'web-app-service'

resource appServiceApp 'Microsoft.Web/sites@2025-03-01' = {
  // This is the name of the app service. It must be unique across Azure.
  name: WebAppServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    publicNetworkAccess:'Disabled'
    virtualNetworkSubnetId: subnetwebapp.id
    siteConfig: {
      appSettings: [
        {
          name: 'vnetRouteAllEnabled'
          value: 'true'
        }
      ]
    }
    
  //Click CTRL + SPACE to see the available properties for the app service.  
  }
}

output appServiceAppHostname string = appServiceApp.properties.defaultHostName
