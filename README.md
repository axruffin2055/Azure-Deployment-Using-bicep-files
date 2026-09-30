# Azure-Deployment-Using-bicep-files

### Find Resource Types and it's Property Values.
[ARM/Bicep Templates](https://learn.microsoft.com/en-us/azure/templates/)

> If you know the resource type, you can go directly to it with the following URL format: /azure/templates/__{provider-namespace}__/__{resource-type}__. For example, the SQL database reference content is available at: /azure/templates/microsoft.sql/**servers**/**databases**.

### Resource type reference: [Click Here](https://learn.microsoft.com/en-us/azure/governance/resource-graph/reference/supported-tables-resources#resources)

Use resource type info and go directly to that resource type and it's property values.  
Resource type example: microsoft.network/networkinterfaces   
URL on microsoft.network resource type: /azure/templates/microsoft.network/networkinterfaces

Another example:

Type: microsoft.network/virtualnetworks   
Resource type URL: /azure/templates/microsoft.network/virtualnetworks 

### Use decorators  
Example: @description()  
[User defined functions](https://docs.azure.cn/en-us/azure-resource-manager/bicep/user-defined-functions)    

Bicep functions: [Click Here](https://docs.azure.cn/en-us/azure-resource-manager/bicep/bicep-functions)

