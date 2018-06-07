Login-AzureRmAccount


$subscription = "Visual Studio Entreprise"


 Set-AzureRmContext -Subscription $subscription

#All available SKU in current subscription 
Get-AzureRmVM | select -Property @{Label="VmSize";Expression={$_.HardwareProfile.VmSize}} | sort-object -Property VmSize -Unique