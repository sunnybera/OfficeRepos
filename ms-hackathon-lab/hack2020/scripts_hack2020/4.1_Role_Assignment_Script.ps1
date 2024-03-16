<#
---------------------------------------------------------------------------------------------------------------------------------------------
This script will assign Role to users at Resource Group scope in one-to-one mapping. Username and Resource group pair to be fed from CSV file.
---------------------------------------------------------------------------------------------------------------------------------------------
File Name        : 4.1_Role_Assignment_Script
Version          : 1
Requires         : PowerShell Version 3.0 or above
Module           : AzureAD Version 2.0.0.155 or above
Product          : Azure Active Directory,RBAC,Access Control(IAM),ResourceGroups
Account          : sunny.bera@yahoo.co.in
SubscriptionName : Pay-As-You-Go
SubscriptionId   : 21136a83-6993-4d29-acd9-3e4d72309126
TenantId         : c1e130b2-d5ab-467a-ae00-788a2ee2bf06
Environment      : AzureCloud
RoleDefName      : Calib_Contributor
RoleDefName Id   : 84bad91b-ce07-439d-b240-9c3cf03a182d
-------------------------------------------------------------------------------------------------------------------------
Created By    : Sumanth Kadur,Sunny Bera
Created Date  : 15-May-2019
Tested By     : Sunny Bera
Tested Date   : 16-May-2019
Description   : Initial version of script created
-------------------------------------------------------------------------------------------------------------------------
#>

param(
    [Parameter(Mandatory = $True)]
    [string]
    $subscriptionName
)

# sign in
Write-Host "Logging in...";
#Login-AzureRmAccount;
 
# select subscription
Write-Host "Selecting subscription '$subscriptionName'";
Select-AzureRmSubscription -SubscriptionName $subscriptionName;

# EDITABLE - Both the CSV file and RoleDifinitionId for specific role being assigned to be provided

$usersList = Import-Csv "C:\temp\CALIBER 2.0 Hackathon_V2_Final.csv" 
$RoleDefinitionId = "84bad91b-ce07-439d-b240-9c3cf03a182d"

$SubscriptionId = (Get-AzureRmContext).Subscription.Id
foreach ($user in $usersList) {
    $userName = $user.AzRG
    $resourceGroup = $user.AzRG
    Write-Output "Getting User info from AD for $userName"
    $AdUser = Get-AzureRmADUser -SearchString $userName
    $AdUserId = $AdUser.Id 
    Write-Output "Assigning Role for user ID $AdUserId"
    New-AzureRmRoleAssignment -ObjectId $AdUserId -RoleDefinitionId $RoleDefinitionId -Scope /subscriptions/$SubscriptionId/resourceGroups/$resourceGroup
    Write-Output "RoleAssignment completed for $userName"
}
Get-AzureRmADUser