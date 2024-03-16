<#
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

Description      : This script will create the initial Resource group to deploy Vnet, subnet for hackathon event. 
                 : Post Vnet setup it would take input from csv file and accordingly would create Resource groups and 
                 : static public IPs for each team
-------------------------------------------------------------------------------------------------------------------------
Resource Type    : IaaS
Resource List    : Resource Group, VNet, SubNet, Static Ip
Architecture     :
Best Practices   : Resources are deployed incase not found.
Existing Artifact: N/A 
-------------------------------------------------------------------------------------------------------------------------
Version          : V1
Requires         : PowerShell Version 3.0 or above
Module           : Az.Resources
Product          : Azure Active Directory
Account          : xxxxxxxx@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - CALIBER
SubscriptionId   : xxxxxxxx-ea49-47af-a059-d790e9782847
TenantId         : xxxxxxxx-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud
-------------------------------------------------------------------------------------------------------------------------
Created By       : 
Modified Date    : 
Modified By      : Sunny Bera
Modified Date    : 13-March-2020
Description      : Cleaned up the existing script for Caliber 2020
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------


param(
    [Parameter(Mandatory = $True)]
    [string]
    $subscriptionName,
    [Parameter(Mandatory = $True)]
    [string]
    $VnetRegion
)

#>

# sign in
Write-Host "Logging in...";
Login-AzAccount;

 
# Get-AzureRmSubscription
Write-Host "Selecting subscription '$subscriptionName'";
Select-AzSubscription -SubscriptionName $subscriptionName;

# Variable Declaration 

$usersList = Import-Csv "C:\Temp\11.1_cal2020_users.csv" 
$Region = "South Central US"
$VnetResourceGroupName = "np-cal-rg-001"
$SubNetName = "np-cal-snet-001"
$VnetName = "np-cal-vnet-001"
$VnetRegion = "South Central US"


# Create Resource group for Vnet if it doesn't exist
$rgexist = Get-AzResourceGroup | Where-Object { $_.ResourceGroupName -eq $VnetResourceGroupName }
if ($rgexist -eq $null) {
    Write-Output "Resource GroupName $VnetResourceGroupName doesn't exist, creating new one"
    New-AzResourceGroup -Name $VnetResourceGroupName -Location $VnetRegion
    Write-Output "Resource GroupName $VnetResourceGroupName successfully Created"
}
else{
Write-Output "Resource GroupName $VnetResourceGroupName exists"
}

# Create Vnet if it doesn't exist
$vnetExist = Get-AzVirtualNetwork -Name $VnetName -ResourceGroupName $VnetResourceGroupName -ErrorAction Continue
if($vnetExist -eq $null){
    
    # Create Subnet
    $Subnet = New-AzVirtualNetworkSubnetConfig -Name $SubNetName -AddressPrefix 10.0.0.0/20
    Write-Output "SubNet $SubNetName successfully created"
    New-AzureRmVirtualNetwork -Name $VnetName -ResourceGroupName $VnetResourceGroupName -Location $VnetRegion -AddressPrefix 10.0.0.0/16 -Subnet $subnet
    Write-Output "Vnet $VnetName successfully created"
}
else{
    Write-Output "Vnet $VnetName exists"
}

# Create Static Public ip

foreach($row in $usersList) {
    
    $rgName = $row.AzRG
    
    New-AzResourceGroup -Name $rgName -Location $Region
    Write-Host "Resource group provisioned is " $rgName        
    $pip = New-AzPublicIpAddress -Name "$rgName-pip" -ResourceGroupName $rgName -AllocationMethod Static -Location $Region
    Write-Output "Static Public IP created is $rgName-pip"
}

Disconnect-AzAccount
