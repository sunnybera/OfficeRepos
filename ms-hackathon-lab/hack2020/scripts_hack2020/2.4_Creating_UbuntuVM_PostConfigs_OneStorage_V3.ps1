

<#******************************************************************************************************************************************

-------------------------------------------------------------------------------------------------------------------------
This script will create the VMs and run Post Deployment Script in Newly Built VMs 
-------------------------------------------------------------------------------------------------------------------------
File Name        : 2.1_Creating_VM_With_PostConfigs_V1.ps1
Version          : 2.1
Requires         : PowerShell Version 3.0 or above
Module           : AzureAD Version 2.0.0.155 or above
Product          : Azure Active Directory
Account          : caliber2@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - CALIBER
SubscriptionId   : 8a9a4c1c-ea49-47af-a059-d790e9782847
TenantId         : ad912b70-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud

-------------------------------------------------------------------------------------------------------------------------
Created By    : Priti Bhunia 
Created Date  : 28-March-2018
Tested By     : Priti Bhunia
Tested Date   : 28-March-2018
Description   : Create Single VM in multiple resource group with specific OS-Disk name and existing public IP.
                Added IIS extension installation and Boot diagnostic storage account details.

Modified By   : Sumanth Kadur Renuka
Modified Date : 09-May-2019
Description   : Added auto shutdown script and cleaned up the existing script. 

Modified By   : Suman Mukhopadhyay
Modified Date : 14-May-2019
Description   : Addition of Post Deployment Script to Newly Build VMs.
                Added auto shutdown script and cleaned up the existing script.
                Hard coding Admin Credential 

Modified By   : Sunny Bera
Modified Date : 13-March-2020
Description   : Cleaned up the existing script for Caliber 2020.Added resource lock function.AzureRm.Resources

******************************************************************************************************************************************

#Script requires Admin priviledge to install following PS Module:  

Install-Module AzureRm.Resources -Scope CurrentUser
Import-Module AzureRm.Resources


#>


# sign in
Write-Host "Logging in...";
#Login-AzureRmAccount;


#Get-AzureRmSubscription

$usersList = Import-Csv "C:\11.3_cal2020_users.csv" 

# Virtual Network Details#
$VnetResourceGroupName = "np-cal-rg-001"
$VnetName = "np-cal-vnet-001"
$SubNetName = "np-cal-snet-001"

# VM Details

$VmSize = "Standard_DS2_v2"

# EDITABLE - Auto Shutdown (Passed as parameters)
$ShutdownTime = 2300
$TimeZone = "India Standard Time"

# AdminStorage details
$AdminStorageName = "npcalsa001"
$StorageAccountKey = "fR9NJdp0TJrS+gdcQuSJ0gWpYxHz4wq0UQk0C30TvkpbqvlRG4x4rvrQXtWq8eXD8tIvBOoc2nIT30LV1eNbdA=="
$ContainerName = "np-cal-ctn-001"

#Get the VNET details
Write-Host "Getting existing Vnet"
$Vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $VnetResourceGroupName -Name $VnetName

#Get the Subnet details
Write-Host "Getting existing Subnet"
$Subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name $SubNetName -VirtualNetwork $Vnet

#Set the VNET details 
Write-Host "Setting Vnet"
$vnet = Set-AzureRmVirtualNetwork -VirtualNetwork $Vnet

#Set the credentials
$SecurePassword = ConvertTo-SecureString 'Welcome@555' -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("calibadmin", $securePassword) 

foreach($row in $usersList) {
    
    $rgName = $row.AzRG
    $CreatedVmName = $rgName + "-vm"
    $Region = "South Central US"
    
    #Get PIP Details    
    Write-Host "Getting IP $rgname-pip"
    $pip = Get-AzureRmPublicIpAddress -Name "$rgname-pip" -ResourceGroupName $rgname 
    
    Write-Host "Creating Network Interface $rgname-nic"
    $nic = New-AzureRmNetworkInterface -Name "$rgname-nic" -ResourceGroupName $rgname -Location $Region -SubnetId $Vnet.Subnets[0].Id -PublicIpAddressId $pip.Id
        
    # VM Details   
    $computername = "azure-hack-2020"
    Write-Host "Setting VM Config"
    $vm = New-AzureRmVMConfig -VMName $CreatedVmName -VMSize $vmsize
    Write-Host "Setting VMSourceImage"
    $vm = Set-AzureRmVMSourceImage -VM $vm -Skus "VS-2017-Comm-WS2016" -PublisherName MicrosoftVisualStudio -Offer VisualStudio -Version latest
    $diskname = $CreatedVmName + '_OsDisk'
    Write-Host "Setting VMOSDisk"
    $vm = Set-AzureRmVMOSDisk -VM $vm -Name $diskname -StorageAccountType Standard_LRS -DiskSizeInGB 128 -CreateOption FromImage -Caching ReadWrite
    Write-Host "Setting VMOperatingSystem"
    $vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -Computername $computername -Credential $cred -ProvisionVMAgent -EnableAutoUpdate
    Write-Host "Setting VMNetworkInterface"
    $vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id    
   
    # Creating Storage for Boot Diagnostics
    
    $storagename = "npcalrg003calsta"
    $resourcegroupname = "npcalrg003"
    Write-Host "Setting StorageAccount"
    $vm = Set-AzureRmVMBootDiagnostics -VM $VM -Enable -ResourceGroupName $resourcegroupname -StorageAccountName $storagename
   
    # Creating VM
    Write-Host "Creating VM"
    New-AzureRmVM -VM $vm -ResourceGroupName $rgname -Location $Region
    Write-Host $CreatedVmName " created successfully"

    # Enable Auto shutdown    
    $SubscriptionId = (Get-AzureRmContext).Subscription.Id
    $VMResourceId = (Get-AzureRmVM -ResourceGroupName $rgname -Name $CreatedVmName).Id
    $ScheduledShutdownResourceId = "/subscriptions/$SubscriptionId/resourceGroups/$rgname/providers/microsoft.devtestlab/schedules/shutdown-computevm-$CreatedVmName"

    $Properties = @{}
    $Properties.Add('status', 'Enabled')
    $Properties.Add('taskType', 'ComputeVmShutdownTask')
    $Properties.Add('dailyRecurrence', @{'time'= $ShutdownTime})
    $Properties.Add('timeZoneId', $TimeZone)
    $Properties.Add('notificationSettings', @{status='Disabled'; timeInMinutes=15})
    $Properties.Add('targetResourceId', $VMResourceId)

    Write-Host "Enabling Auto Shutdown"
    New-AzureRmResource -Location $Region -ResourceId $ScheduledShutdownResourceId -Properties $Properties -Force
    
    Write-Host $CreatedVmName "is now getting POST-Deployment Configuration"

    Set-AzureRmVMCustomScriptExtension -ResourceGroupName "$rgname" -Location $Region -VMName "$CreatedVmName" -Name "VMConfigScript" -TypeHandlerVersion "1.1" -StorageAccountName $AdminStorageName -StorageAccountKey $StorageAccountKey -FileName "2.2_ForNewlyBuiltVM_V1.ps1" -ContainerName $ContainerName
    
    Write-Host "VM provisioning successfully completed"

    #Locking resource group
    New-AzureRmResourceLock -LockName LockGroup -LockLevel CanNotDelete -ResourceGroupName $rgname -force
}
#Logout-AzureRmAccount
    