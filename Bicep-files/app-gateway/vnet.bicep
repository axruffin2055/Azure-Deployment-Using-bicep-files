param location string = resourceGroup().location

param virtualNetworkName string = 'webapp-vnet'
param virtualNetworkAddressPrefix string = '12.0.0.0/16'

@description('App Gateway Only. For WAF-v2')
param snetappgw string = 'snet-appgateway'
param subnetappgwPrefix string = '12.0.1.0/24'

@description('For the private endpoint of the web app. Need to disable the private endpoint network policies for this subnet')
param snetpe string = 'snet-privateendpoint'
param subnetprivateendpointPrefix string = '12.0.2.0/24'

@description('For Vnet integration of the web app outbound traffic. Need to enable the service endpoint for Microsoft.Web for this subnet')
param snetwebapp string = 'snet-webapp'
param subnetwebappPrefix string = '12.0.3.0/24'





resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-04-01-preview' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [virtualNetworkAddressPrefix]
    }
    
    subnets: [{
        name: snetappgw
        properties: {
          addressPrefix: subnetappgwPrefix
        }
      }
      {
        name: snetpe 
        properties: {
          addressPrefix: subnetprivateendpointPrefix
          privateEndpointNetworkPolicies: 'Disabled'
        }
      }
      {
        name: snetwebapp
        properties: {
          addressPrefix: subnetwebappPrefix
          delegations: [{
              name: 'delegation-webapp'
              properties: {
               serviceName: 'Microsoft.Web/serverFarms'
              }
            }]
        }
     }]
  }
}


