

<#******************************************************************************************************************************************

-------------------------------------------------------------------------------------------------------------------------
Description      : This script will create the VMs and run Post Deployment Script in Newly Built VMs 
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------
Resource Type    : IaaS
Resource List    : NIC, storage Account, VM, OS Disk, VM custom Extentention
Architecture     :
Best Practices   : Resources are deployed incase not found.
Existing Artifact: N/A 
-------------------------------------------------------------------------------------------------------------------------
Version          : V1
Requires         : PowerShell Version 3.0 or above
Module           : Az.Resources
Account          : xxxxxxxx@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - CALIBER
SubscriptionId   : xxxxxxxx-ea49-47af-a059-d790e9782847
TenantId         : xxxxxxxx-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud

-------------------------------------------------------------------------------------------------------------------------
Modified By   : Sunny Bera
Modified Date : 16-April-2020
Description   : Cleaned up the existing script for Caliber 2020.Added resource lock function.Upgraded skuname=<2019-datacenter-with-containers-g2>, vmsize=<D4s_v3> for Hyper-v and IOT edge
                functionalities

******************************************************************************************************************************************
#>

# sign in
Write-Host "Logging in...";
Login-AzAccount;


## EDITABLE - Variable Declaration ##

#Get-AzSubscription

$usersList = Import-Csv "C:\Temp\11.1_cal2020_users.csv" 

# Virtual Network Details#
$VnetResourceGroupName = "np-cal-rg-001"
$VnetName = "np-cal-vnet-001"
$SubNetName = "np-cal-snet-001"
$Location = "South Central US"

# VM Details

$VmSize = "Standard_DS2_v2"
#$VmSize = "Standard_D4_v3"
#$VmSize = "Standard_NV4as_v4"
$computername = "azure-hack-2020"

# EDITABLE - Auto Shutdown (Passed as parameters)
$ShutdownTime = 2300
$TimeZone = "India Standard Time"

# Storage details for Boot Diagnostics
    
$storagename = "npcalrg003calsta"
$resourcegroupname = "npcalrg003"

# VM Custom Script Extension storage details
$AdminStorageName = "npcalsa001" 
$StorageAccountKey = (Get-AzKeyVaultSecret -VaultName caliber2 -Name StorageAccount).SecretValueText
$ContainerName = "np-cal-ctn-001"


#Get the VNET details
Write-Host "Getting existing Vnet"
$Vnet = Get-AzVirtualNetwork -ResourceGroupName $VnetResourceGroupName -Name $VnetName

#Get the Subnet details
Write-Host "Getting existing Subnet"
$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubNetName -VirtualNetwork $Vnet

#Set the VNET details 
Write-Host "Setting Vnet"
$vnet = Set-AzVirtualNetwork -VirtualNetwork $Vnet

#Set the credentials 
$useradmin = "calibadmin"
$SecurePassword = (Get-AzKeyVaultSecret -VaultName caliber2 -Name $useradmin).SecretValueText
$SecurePassword = ConvertTo-SecureString -String $SecurePassword -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $useradmin,$SecurePassword 

foreach($row in $usersList) {
    
    $rgName = $row.AzRG
    $CreatedVmName = $rgName + "-vm"
    $Region = $Location
    

    #Get PIP Details    
    Write-Host "Getting IP $rgname-pip"
    $pip = Get-AzPublicIpAddress -Name "$rgname-pip" -ResourceGroupName $rgname 
    
    Write-Host "Creating Network Interface $rgname-nic"
    $nic = New-AzNetworkInterface -Name "$rgname-nic" -ResourceGroupName $rgname -Location $Region -SubnetId $Vnet.Subnets[0].Id -PublicIpAddressId $pip.Id
        
    # VM Details   
    
    Write-Host "Setting VM Config"
    $vm = New-AzVMConfig -VMName $CreatedVmName -VMSize $vmsize
    Write-Host "Setting VMSourceImage"
    
    # EDITABLE -
    #$vm = Set-AzVMSourceImage -VM $vm -Skus "VS-2017-Comm-WS2016" -PublisherName MicrosoftVisualStudio -Offer VisualStudio -Version latest
    $vm = Set-AzVMSourceImage -VM $vm -Skus "2019-Datacenter-with-Containers" -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Version latest
    
    $diskname = $CreatedVmName + '_OsDisk'
    Write-Host "Setting VMOSDisk"
    $vm = Set-AzVMOSDisk -VM $vm -Name $diskname -StorageAccountType Standard_LRS -DiskSizeInGB 128 -CreateOption FromImage -Caching ReadWrite
    Write-Host "Setting VMOperatingSystem"
    $vm = Set-AzVMOperatingSystem -VM $vm -Windows -Computername $computername -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
    Write-Host "Setting VMNetworkInterface"
    $vm = Add-AzVMNetworkInterface -VM $vm -Id $nic.Id    
   
    # Creating Storage for Boot Diagnostics
    
    Write-Host "Setting StorageAccount"
    $vm = Set-AzVMBootDiagnostics -VM $VM -Enable -ResourceGroupName $resourcegroupname -StorageAccountName $storagename
   
    # Creating VM
    Write-Host "Creating VM"
    New-AzVM -VM $vm -ResourceGroupName $rgname -Location $Region
    Write-Host $CreatedVmName " created successfully"

    # Enable Auto shutdown    
    $SubscriptionId = (Get-AzContext).Subscription.Id
    $VMResourceId = (Get-AzVM -ResourceGroupName $rgname -Name $CreatedVmName).Id
    $ScheduledShutdownResourceId = "/subscriptions/$SubscriptionId/resourceGroups/$rgname/providers/microsoft.devtestlab/schedules/shutdown-computevm-$CreatedVmName"

    $Properties = @{}
    $Properties.Add('status', 'Enabled')
    $Properties.Add('taskType', 'ComputeVmShutdownTask')
    $Properties.Add('dailyRecurrence', @{'time'= $ShutdownTime})
    $Properties.Add('timeZoneId', $TimeZone)
    $Properties.Add('notificationSettings', @{status='Disabled'; timeInMinutes=15})
    $Properties.Add('targetResourceId', $VMResourceId)

    Write-Host "Enabling Auto Shutdown"
    New-AzResource -Location $Region -ResourceId $ScheduledShutdownResourceId -Properties $Properties -Force
    
    Write-Host $CreatedVmName "is now getting POST-Deployment Configuration"

    Set-AzVMCustomScriptExtension -ResourceGroupName "$rgname" -Location $Region -VMName "$CreatedVmName" -Name "VMConfigScript" -TypeHandlerVersion "1.1" -StorageAccountName $AdminStorageName -StorageAccountKey $StorageAccountKey -FileName "2.2_ForNewlyBuiltVM_V1.ps1" -ContainerName $ContainerName
      
    Write-Host "VM provisioning successfully completed"

    #Locking resource group
    New-AzResourceLock -LockName LockGroup -LockLevel CanNotDelete -ResourceGroupName $rgname -force
}
Logout-AzAccount
    