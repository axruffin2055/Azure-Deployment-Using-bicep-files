@description(Parameter values in a parameter file takes precedence over param values in bicep templates.)
@description(Notice the 'using' ./whatever-name-file that will be using this param file.)

using './storage.bicep'

param storageAccountName = 'devstore'
param location = 'westus2'
param skuType = 'Standard_LRS'
