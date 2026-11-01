resource vnet 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      for subnet in subnets: {
        name: subnet.name
        properties: {
          addressPrefix: subnet.addressPrefix
          networkSecurityGroup: subnet.nsgId != '' ? {
            id: subnet.nsgId
          } : null
          routeTable: subnet.routeTableId != '' ? {
            id: subnet.routeTableId
          } : null
        }
      }
    ]
  }
}   
    
