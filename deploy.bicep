/**
We have three section(parameter, variable, and resource).
We will deploy two resource types ('Microsoft.Web/serverfarms@2022-03-01' and 'Microsoft.Web/sites@2022-03-01')
Resource have symbolic names (appServicePlan and webAppPortal) These names are the resources object/ resource referance.
We have two types of sytax (location: location vs name: 'AwesomeAppServicePlan') 
location is a parameter the referance something else so no quotations. 
'AwesomeAppServicePlan' is a variable   
**/


param location string = resourceGroup().location
param webAppName string   //We will be prompted with this parameter.

var sku = 'S1'
var linuxFxVersion = 'php|7.4'

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: 'AwesomeAppServicePlan'  //The of the resource
  location: location             
  sku: {
    name: sku
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource webAppPortal 'Microsoft.Web/sites@2022-03-01' = {
  name: 'AwesomeApp' //webApps has to have unique name. We will create a dynamic variable above.
  name: webAppName   //This name will replace the hard coded name: 'AwesomeApp'
  location: location   //this is using a built-in function asigned to this parameter 
                       //(param location string = resourceGroup().location)
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id   //symbolic resource referance from resource above. It will look for the info
                                      //in the appServicePlan above for the serverFarmId ID.
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      ftpsState: 'FtpsOnly'
    }
    httpsOnly: true
  }
  identity: {
    type: 'SystemAssigned'
  }
}
