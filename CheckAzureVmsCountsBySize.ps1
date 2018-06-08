Login-AzureRmAccount

# Define all the subscriptions in an array ( replace the subscription name )
$subscriptions = "Visual Studio Entreprise, Dev Essential"

# in subscription
ForEach($subscription in $subscriptions){
    Set-AzureRmContext -Subscription $subscription
   
    $vms = Get-AzureRmVM | select -Property @{Label="VmSize";Expression={$_.HardwareProfile.VmSize}} 
    $sizes = $vms | sort-object -Property VmSize -Unique
    $count = 0
    $total = 0
    Foreach($size in $sizes){
        Foreach($vm in $vms){
            If($vm.VmSize -eq $size.VmSize){
              $count ++ 
              $total ++
            }
        }
     
        Write-Output ("There are " + $count +" Azure VMs for the SKU " + $size.VmSize + "in subscription " +  $subscription )
        $count = 0 
      
    }
     Write-Output " "
     Write-Output ("There are totally " + $total + " in subscription " +  $subscription )
     Write-Output " "
}
