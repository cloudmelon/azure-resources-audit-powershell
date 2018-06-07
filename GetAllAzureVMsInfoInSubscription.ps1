Login-AzureRmAccount


$subscription = "Visual Studio Entreprise"


 Set-AzureRmContext -Subscription $subscription


#list all the vms group by VM Size
Get-AzureRmVM | Select -Property Name, @{Label="OsType";Expression={$_.StorageProfile.OsDisk.OsType}}, @{Label="VmSize";Expression={$_.HardwareProfile.VmSize}} |Sort-Object -Property VmSize 