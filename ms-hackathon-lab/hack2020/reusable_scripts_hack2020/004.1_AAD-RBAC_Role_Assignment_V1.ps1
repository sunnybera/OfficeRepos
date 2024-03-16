<#
---------------------------------------------------------------------------------------------------------------------------------------------
Description      : This script will assign subscription and directory role to users at defined scope in one-to-one mapping. 
                 : Username and Resource group pair to be fed from CSV file.
---------------------------------------------------------------------------------------------------------------------------------------------
Resource Type    : PaaS
Resource List    : AD Member subscription/role assignment to Resource Group/subscription scope, Directory role assignment 
Architecture     :
Best Practices   : Users with existing subscription and directory role asignment are skipped   
Existing Artifact: N/A 
-------------------------------------------------------------------------------------------------------------------------
Version          : V1
Requires         : PowerShell Version 3.0 or above
Module           : Az.Resources, AzureADPreview, AzureAD Version 2.0.0.155 or above
Account          : xxxxxxxx@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - xxxxxxxx
SubscriptionId   : xxxxxxxx-ea49-47af-a059-d790e9782847
TenantId         : xxxxxxxx-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud

-------------------------------------------------------------------------------------------------------------------------
Created By    : Sunny Bera
Created Date  : 16-April-2020
Description   : Cleaned up the existing script for Caliber 2020.
Modified By   : 
Modified Date : 
Description 

******************************************************************************************************************************************
#>

# Mandatory sign in
Write-Host "Logging in...";
Connect-AzureAD;

$subscriptionName = 'Microsoft Azure Enterprise - CALIBER'
 
# select subscription
Write-Host "Selecting subscription '$subscriptionName'";
Select-AzSubscription -SubscriptionName $subscriptionName;



# EDITABLE - CSV file, RoleDifinitionName and DirectoryRole to be provided

$usersList = Import-Csv "C:\Temp\11.1_cal2020_users.csv" 
$RoleDefinitionName = "Calib_Contributor_V2"
$DirectoryRole = "Application Administrator"

$SubscriptionId = (Get-AzContext).Subscription.Id
foreach ($user in $usersList) {
    $userName = $user.AzRG
    $resourceGroup = $user.AzRG
    #Write-Output "Getting User info from AD for $userName"
    $AdUser = Get-AzureADUser -SearchString $userName
    $AdUserId = $AdUser.ObjectId 
    Write-Output "Assigning Subscription for user ID $AdUserId"
    New-AzRoleAssignment -ObjectId $AdUserId -RoleDefinitionName $RoleDefinitionName -Scope /subscriptions/$SubscriptionId/
    Write-Output "Subscription Assignment completed for $userName"

Write-Host "Directory Role Assignment started for $userName"

# EDITABLE - Fetch User Account Administrator role instance.
$DirectoryRole = Get-AzureADDirectoryRole | Where-Object {$_.displayName -eq $DirectoryRole}

# Add user to role
Add-AzureADDirectoryRoleMember -ObjectId $DirectoryRole.ObjectId -RefObjectId $AdUserId

Write-Host "Directory Role Assignment completed for $userName"

}
Disconnect-AzureAD