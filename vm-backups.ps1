$ResourceGroupName= "" #all the VMs in this Resource Group will be checked for Vault specified below
$VaultName = "" 

Get-AzureRmRecoveryServicesVault -Name $VaultName -ResourceGroupName $ResourceGroupName | Set-AzureRmRecoveryServicesVaultContext
$fnames = Get-AzureRmRecoveryServicesBackupContainer -ContainerType "AzureVM" -Status "Registered" | select  -ExpandProperty friendlyname
$vaultVMs=@()
foreach ($name in $fnames)
{
    $nameContainer = Get-AzureRmRecoveryServicesBackupContainer -ContainerType "AzureVM" -Status "Registered" -FriendlyName $name
    $vaultVMs += Get-AzureRmRecoveryServicesBackupItem -Container $nameContainer -WorkloadType "AzureVM" | select VirtualMachineId
}

 $vms = Get-AzureRmVM -ResourceGroupName $ResourceGroupName
 foreach ($vm in $vms)
 {
    $j = 0;
    for ($i=0; $i -lt $vaultVMs.Count; $i++)
    {
        if ($vm.id -eq $vaultVMs[$i].VirtualMachineId)
        {
               $j++
        }
    }
    if ($j -eq 0)
    {
        Write-Host "$($vm.name) is not backed up in this vault"
    }
    else
    {
        Write-Host "$($vm.Name) is backed up in this vault"
    }
 }