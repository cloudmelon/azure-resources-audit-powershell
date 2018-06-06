
## Retrieve Azure Virtual Machine Size information in current subscription with PowerShell

################################################### Login ###################################################
Login-AzureRmAccount

### Select Subscription ####
$subscription = "Visual Studio Enterprise"
Set-AzureRmContext -Subscription $subscription


###################################################  Audit start ###################################################


#Get all resources in current subscription
$resources = Get-AzureRmResource 

#Get all resource groups in current subscription 
$rgs = Get-AzureRmResourceGroup

# Sort all the resource in current subscription by resource type
$ResourceTypes = $resources.ResourceType | Sort-Object -Unique 

# Get Resource count for each resource type in Azure
 foreach ($ResType in $ResourceTypes) { 
    $ResCount = ($resources | Where-Object {$_.ResourceType -eq $ResType -and $_.ResourceGroupName -eq $rg.ResourceGroupName}).count 
    if ($ResCount -eq $null) { 
        $ResCount = 1 
     } 
     Write-Output ("In current subscription "+ $subscription + "the resource type "+ $ResType + " have : " + $ResCount )
} 

Write-Output ("Here are the details in subscription "+ $subscription + " each resource type in resource group : " )

# Get Resource count for each resource type order by resource group 
Foreach( $rg in $rgs){
   Write-Host " "
   Write-Host $rg.ResourceGroupName  
   foreach ($ResType in $ResourceTypes) { 
    Write-Host -NoNewline $ResType
    $ResCount = ($resources | Where-Object {$_.ResourceType -eq $ResType -and $_.ResourceGroupName -eq $rg.ResourceGroupName}).count 
    if ($ResCount -eq $null) { 
        $ResCount = 1 
     }  
    
     Write-Host -NoNewline ( "  " + $ResCount + " , " ) 
     #Start-Sleep –Seconds 1    
   } 
   Write-Host " "
}




