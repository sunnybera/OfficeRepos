<#
-------------------------------------------------------------------------------------------------------------------------
This script will create the Resource group for admin and Vnet. Also Resource groups and a static public IP for each team 
-------------------------------------------------------------------------------------------------------------------------
File Name        : 1.1_Creating_RG_PIP_V1.ps1
Version          : 1.1
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
Created Date  : 11-December-2017 
Tested By     : Priti Bhunia
Tested Date   : 11-December-2017
Description   : To create Resource Group and Static Public IP Address
-------------------------------------------------------------------------------------------------------------------------
Modified By   : Sunny Bera
Modified Date : 12-April-2019
Description   : Added Scripts to be run onetime for VNet,Subnet & Storage Acct.
                Changed Naming convention for Caliber 2.0 Hackathon
-------------------------------------------------------------------------------------------------------------------------
Modified By   : Sumanth Kadur Renuka
Modified Date : 09-May-2019
Description   : Cleaned up the existing script. 
-------------------------------------------------------------------------------------------------------------------------
Modified By   : Sunny Bera
Modified Date : 13-March-2020
Description   : Cleaned up the existing script for Caliber 2020. 
-------------------------------------------------------------------------------------------------------------------------

param(
    [Parameter(Mandatory = $True)]
    [string]
    $subscriptionName,
    [Parameter(Mandatory = $True)]
    [string]
    $VnetRegion
)

# sign in
Write-Host "Logging in...";
#Login-AzureRmAccount;

 
# Get-AzureRmSubscription
Write-Host "Selecting subscription '$subscriptionName'";
Select-AzureRmSubscription -SubscriptionName $subscriptionName;

#>

$usersList = Import-Csv "C:\Temp\11.3_cal2020_users.csv" 
#$Region = "South Central US"
$Region = "East US"
$VnetResourceGroupName = "np-cal-rg-001"
#$PipResourceGroupName = "np-cal-rg-001"
$SubNetName = "np-cal-snet-001"
$VnetName = "np-cal-vnet-001"
#$VnetRegion = "South Central US"
$VnetRegion = "East US"


# Create Resource group for Vnet
$rgexist = Get-AzureRmResourceGroup | Where-Object { $_.ResourceGroupName -eq $VnetResourceGroupName }
if ($rgexist -eq $null) {
    Write-Output "Resource GroupName $VnetResourceGroupName doesn't exist, creating new one"
    New-AzureRmResourceGroup -Name $VnetResourceGroupName -Location $VnetRegion
    Write-Output "Resource GroupName $VnetResourceGroupName successfully Created"
}
else{
Write-Output "Resource GroupName $VnetResourceGroupName exists"
}

# Create Vnet if it doesn't exist
$vnetExist = Get-AzureRmVirtualNetwork -Name $VnetName -ResourceGroupName $VnetResourceGroupName -ErrorAction Continue
if($vnetExist -eq $null){
    
    # Create Subnet
    $Subnet = New-AzureRmVirtualNetworkSubnetConfig -Name $SubNetName -AddressPrefix 10.0.0.0/20
    Write-Output "SubNet $SubNetName successfully created"
    New-AzureRmVirtualNetwork -Name $VnetName -ResourceGroupName $VnetResourceGroupName -Location $VnetRegion -AddressPrefix 10.0.0.0/16 -Subnet $subnet
    Write-Output "Vnet $VnetName successfully created"
}
else{
    Write-Output "Vnet $VnetName exists"
}

foreach($row in $usersList) {
    
    $rgName = $row.AzRG
    
    New-AzureRmResourceGroup -Name $rgName -Location $Region
    Write-Host "Resource group provisioned is " $rgName        
    $pip = New-AzureRmPublicIpAddress -Name "$rgName-pip" -ResourceGroupName $rgName -AllocationMethod Static -Location $Region
    Write-Output "Static Public IP created is $rgName-pip"
}

#Disconnect-AzureRmAccount
