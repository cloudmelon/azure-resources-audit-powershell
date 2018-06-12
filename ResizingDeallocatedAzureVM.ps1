Login-AzureRmAccount

#At moment for one subscription 
$subscription = "Visual Studio Entreprise"
Set-AzureRmContext -Subscription $subscription

$vms = Get-AzureRmVM | Select -Property Name, @{Label="OsType";Expression={$_.StorageProfile.OsDisk.OsType}}, @{Label="VmSize";Expression={$_.HardwareProfile.VmSize}} | Sort-Object -Property VmSize 


#Get Azure VM Status

$vmstatus = Get-AzureRmVM -Status | Select ResourceGroupName, Name, PowerState

$rgs = Get-AzureRmResourceGroup
$NewVMSizeStandard_A2 = "Standard_A2_v2"
$NewVMSizeStandard_A3 = "Standard_A4_v2"


Foreach($vm in $vms){

    $filteredStatuses = $vmstatus |
        where-object { $_.Name -eq $vm.Name }

    foreach ($s in $filteredStatuses) {
       $obj = New-Object -TypeName PSObject -Property @{
        Name = $s.Name
        OsType = $vm.OsType
        VMSize = $vm.VmSize
        VMStatus = $s.PowerState
        ResourceGroupName = $s.ResourceGroupName
      }
    }
     Foreach($v in $vms){
          If($obj.VmSize -eq "Standard_A1" ){
               Resize-AzureVM $obj.ResourceGroupName $obj.Name $NewVMSizeStandard_A1  
           }
           ElseIf($obj.VmSize -eq "Standard_A2"){
              Resize-AzureVM $obj.ResourceGroupName $obj.Name $NewVMSizeStandard_A2     
           }  
    
    }
}








Function Resize-AzureVM{
   Param ($rgname, $objname,$newSize)
    $vm = Get-AzureRmVM -ResourceGroupName $rgname -Name $objname
        if($vm -eq $null){
           Write-Host "No VM found "
        }else{
           Write-Host "since vm " + $objname + "is being resized from" + $vm.HardwareProfile.vmSize + " to " + $newSize
           $vm.HardwareProfile.vmSize = $newSize
           Update-AzureRmVM -ResourceGroupName $rgname -VM $vm
          
        }
}