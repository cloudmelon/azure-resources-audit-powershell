Add-AzureAccount
Import-Module Azure

$subscription  = "Visual Studio Dev Essentials"  
Select-AzureSubscription -SubscriptionName $subscription

$vms = Get-AzureVM


# All the new size no B series in classic VMs 
$NewSizeStandard_A1 = "Standard__A1_v2"
$NewSizeStandard_A2 = "Standard_A2_v2"
$NewSizeStandard_A3 = "Standard_A4_v2"
$NewSizeStandard_A4 = "Standard_A8_v2"
$NewSizeStandard_DS2_v2 = "Standard_DS2_v3"


#specify information and resize the VMs
 

Foreach ($vm in $vms) {
      
  $obj = New-Object -TypeName PSObject -Property @{ 
        Name         = $vm.InstanceName;` 
        VmStatus   = $vm.PowerState;` 
        VmSize         = $vm.InstanceSize
        Service      = $vm.ServiceName
    } 

    Write-Host ("VMs are : " + $vm.Name + " : " + $obj.VmStatus + " " + $obj.VmSize + " " + $obj.Size)


    If ($obj.VmStatus -eq "StoppedDeallocated" -or $obj.VmStatus -eq "Stopped") {
        If ($obj.VmSize -eq "ExtraSmall" ) {
            Resize-AzureVM $obj.Name $obj.Service $NewSizeStandard_A1  
        }
        ElseIf ($obj.VmSize -eq "Small") {
            Resize-AzureVM $obj.Name $obj.Service $NewSizeStandard_A2     
        }
        ElseIf ($obj.VmSize -eq "Medium") {
            Resize-AzureVM $obj.Name $obj.Service $NewSizeStandard_A2     
        }
        ElseIf ($obj.VmSize -eq "Large") {
            Resize-AzureVM $obj.Name $obj.Service $NewSizeStandard_A3     
        }
        ElseIf ($obj.VmSize -eq "ExtraLarge") {
            Resize-AzureVM $obj.Name $obj.Service $NewSizeStandard_A4  
        }
        ElseIf ($obj.VmSize -eq "Standard_DS2_v2") {
            Resize-AzureVM $obj.Name $obj.Service $NewSizeStandard_DS2_v2 
        }
        
        Else {
            Write-Host "VM " + $obj.Name + "is not resized"
        }
    }
    Else {
        Write-Host "VM " + $obj.Name + "is running"
    }

    Function Resize-AzureVM {
        Param ($objname, $objservice, $newSize)
       
        Write-Host ("VM " + $objname + " is being resized from " + $vm.InstanceSize + " to " + $newSize)
        Get-AzureVM -ServiceName $objservice -Name $objname | Set-AzureVMSize -InstanceSize $newSize | Update-AzureVM
      
    }  
} 
