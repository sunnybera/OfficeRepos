<#
---------------------------------------------------------------------------------------------------------------------------------------------
This script will assign Role to users at Resource Group scope in one-to-one mapping. Username and Resource group pair to be fed from CSV file.
---------------------------------------------------------------------------------------------------------------------------------------------
File Name        : 4.2_Role_Assignment_Script
Version          : 1
Requires         : PowerShell Version 3.0 or above
Module           : AzureAD Version 2.0.0.155 or above
Product          : Azure Active Directory,RBAC,Access Control(IAM),ResourceGroups
Account          : caliber2@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - CALIBER
SubscriptionId   : 8a9a4c1c-ea49-47af-a059-d790e9782847
TenantId(CTS)    : de08c407-19b9-427d-9fe8-edf254300ca7
TenantId(CALIBER): ad912b70-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud
RoleDefName      : Calib_Contributor
RoleDefName Id   : 84bad91b-ce07-439d-b240-9c3cf03a182d
RoleDefName      : Calib_Contributor_V1
RoleDefName Id   : 9d05fae6-5ec7-4ad6-b4f2-51ad19c13fad
RoleDefName      : Owner
RoleDefName Id   : 8e3af657-a8ff-443c-a75c-2fe8c4bcb635
RoleDefName      : Contributor
RoleDefName Id   : b24988ac-6180-42a0-ab88-20f7382dd24c
-------------------------------------------------------------------------------------------------------------------------
Created By    : Sumanth Kadur,Sunny Bera
Created Date  : 15-May-2019
Tested By     : Sunny Bera
Tested Date   : 16-May-2019
Description   : Initial version of script created
-------------------------------------------------------------------------------------------------------------------------



param(
    [Parameter(Mandatory = $True)]
    [string]
    $subscriptionName
)


#>

# sign in
Write-Host "Logging in...";
#Login-AzureRmAccount;
#Connect-AzureAD;
 
# select subscription
Write-Host "Selecting subscription '$subscriptionName'";
Select-AzureRmSubscription -SubscriptionName $subscriptionName;

# EDITABLE - Both the CSV file and RoleDifinitionId for specific role being assigned to be provided

$usersList = Import-Csv "C:\11.3_cal2020_users.csv" 
$RoleDefinitionId = "9d05fae6-5ec7-4ad6-b4f2-51ad19c13fad"

$SubscriptionId = (Get-AzureRmContext).Subscription.Id
foreach ($user in $usersList) {
    $userName = $user.AzRG
    $resourceGroup = $user.AzRG
    #Write-Output "Getting User info from AD for $userName"
    $AdUser = Get-AzureRmADUser -SearchString $userName
    $AdUserId = $AdUser.Id 
    #Write-Output "Assigning Role for user ID $AdUserId"
    New-AzureRmRoleAssignment -ObjectId $AdUserId -RoleDefinitionId $RoleDefinitionId -Scope /subscriptions/$SubscriptionId/
    Write-Output "RoleAssignment completed for $userName"

#Write-Host "Directory Role Assignment started for $userName"

Get-AzureADUser -ObjectId $AdUserId
 
# Fetch User Account Administrator role instance
$DirectoryRole = Get-AzureADDirectoryRole | Where-Object {$_.displayName -eq 'Application Administrator'}

# Add user to role
Add-AzureADDirectoryRoleMember -ObjectId $DirectoryRole.ObjectId -RefObjectId $AdUserId

# Fetch role membership for role to confirm
Get-AzureADDirectoryRoleMember -ObjectId $DirectoryRole.ObjectId | Get-AzureADUser

Write-Host "Directory Role Assignment completed for $userName"

}
