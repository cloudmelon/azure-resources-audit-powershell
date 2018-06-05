Login-AzureRmAccount

$subscription = "Visual Studio Enterprise"
Set-AzureRmContext -Subscription $subscription


################################################### List all the VMs  ###################################################
#all the vms in the same size ( list vm but with size information ) 

Write-Output ("There are "+ + (Get-AzureRmVM).length + " Virtual machines in current subscription, here they are : ")


#Get all resource groups in current subscription 
$rgs = Get-AzureRmResourceGroup

#Current subscription count :
Write-Output ("Here are the details in subscription "+ $subscription + " each resource type in resource group : " )

#Get all resources in resource group then list by VM size
$rgs = Get-AzureRmResourceGroup

   Write-Output "VmName,VmInResourceGroup,VmSize,NumberOfCores,MemoryInMB,MaxDataDiskCount,OSDiskSizeInMB,ResourceDiskSizeInMB"
   Get-AzureRmVM |  ForEach {
   $Availablevmsize = Get-AzureRmVMSize -ResourceGroupName $_.ResourceGroupName -VMName $_.Name
   Foreach($size in $Availablevmsize){
      If ($_.hardwareProfile.vmSize -eq $size.Name ) {  
         Write-Output ($_.Name + "," + $_.ResourceGroupName + "," + $size.Name  + "," + $size.NumberOfCores + "," + $size.MemoryInMB  + "," + $size.MaxDataDiskCount  + "," + $size.OSDiskSizeInMB  + "," + $size.ResourceDiskSizeInMB)
      }
   }
  } |Sort-Object -Property VmSize 



