

################################################### Login ###################################################
Login-AzureRmAccount

$subscription = "Visual Studio Enterprise"
Set-AzureRmContext -Subscription $subscription


################################################### Clean prep work : Overview start ###################################################


#Get all resources 
$resources = Get-AzureRmResource 

#Get all resource groups in current subscription 
$rgs = Get-AzureRmResourceGroup


$ResourceTypes = $resources.ResourceType | Sort-Object -Unique 

#Current subscription :
 foreach ($ResType in $ResourceTypes) { 
    $ResCount = ($resources | Where-Object {$_.ResourceType -eq $ResType -and $_.ResourceGroupName -eq $rg.ResourceGroupName}).count 
    if ($ResCount -eq $null) { 
        $ResCount = 1 
     } 
     Write-Output ("In current subscription "+ $subscription + "the resource type "+ $ResType + " have : " + $ResCount )
} 

Write-Output ("Here are the details in subscription "+ $subscription + " each resource type in resource group : " )
#Get all resources in resource group OK
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

###################################################  Clean prep work : Overview end ###################################################


