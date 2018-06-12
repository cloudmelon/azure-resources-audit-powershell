# Purge a resource group 

New-AzureRmResourceGroupDeployment -ResourceGroupName testvmssnewfeatureone -Mode Complete -TemplateFile .\resource\ResourceGroupPurge.template.json -Force -Verbose