# Azure-Deployment-Using-bicep-files

Find Resource Types and it's Property Values.

If you know the resource type, you can go directly to it with the following URL format: /azure/templates/{provider-namespace}/{resource-type}. For example, the SQL database reference content is available at: /azure/templates/microsoft.sql/servers/databases.

Resource type reference: Gain templates on resources for your Bicep files:
https://learn.microsoft.com/en-us/azure/governance/resource-graph/reference/supported-tables-resources#resources

Use resource type info and go directly to that resource type and it's property values.  
Resource type example: microsoft.network/networkinterfaces 
URL on microsoft.network resource type: /azure/templates/microsoft.network/networkinterfaces

Another example:

Type: microsoft.network/virtualnetworks 
Resource type URL: /azure/templates/microsoft.network/virtualnetworks 

Use decorators 
https://docs.azure.cn/en-us/azure-resource-manager/bicep/user-defined-functions  
Example: @description

Bicep functions: https://docs.azure.cn/en-us/azure-resource-manager/bicep/bicep-functions

