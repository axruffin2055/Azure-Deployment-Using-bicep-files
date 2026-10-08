@description("This main.bicep file passes parameters to the module.bicep; therefore, module.bicep
              do not need hard coded values.")
@description("main.bicep file focus on resource orchestration, while module.bicep focus on resource deployment")

param accountName string = 'devstore'
param location string = 'westus2'

module storageModule './module.bicep' =
{
  @description("This is the name of this deployment. Deployment names helps with tracking.")
  name: 'storageDeployment'  
  params: {
    storageAccountName: accountName
    location: location
  }
}
