Connect-AzAccount

$context = Get-AzSubscription -SubscriptionName 'Anthony Subscription' | Select-AzSubscription
Set-AzContext $context

New-AzResourceGroup -Name 'Bicep-DeployResourcesConditionally' -Location 'eastus' -Force

$Parameters = @{
Name = "exampleDeployment" + (Get-Date).ToString("yyyyMMddHHmmss")
TemplateFile = 'deploy-sqlserver-with-storage-conditionally.bicep'
ResourceGroupName = 'Bicep-DeployResourcesConditionally'
}
New-AzResourceGroupDeployment @Parameters -Verbose

# If we want to deploy Production environment, we can use the following
# command to deploy the resources to a different resource group.
$Parameters.ResourceGroupName = "Bicep-DeployResourcesConditionally-Prod"

New-AzResourceGroupDeployment @Parameters -environmentName Production -Verbose

