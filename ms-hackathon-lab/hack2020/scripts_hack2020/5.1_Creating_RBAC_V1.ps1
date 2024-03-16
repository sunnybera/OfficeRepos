    
<#
-----------------------------------------------------------------------
Custom Role Based Access creation for Users/Groups
-----------------------------------------------------------------------

File Name : 5.1_Creating_RBAC_V1
Author    : Sunny Bera
Version   : 1
Date      : 17-May-2019
Update    : 
Requires  : PowerShell Version 3.0 or above
Module    : AzureAD Version 2.0.0.155 or above
Product   : Azure Active Directory,IAM,JSON,PowerShell,RBAC 
Account          : sunny.bera@cognizant.com
SubscriptionName : Microsoft Azure Enterprise - CALIBER
SubscriptionId   : 8a9a4c1c-ea49-47af-a059-d790e9782847
TenantId(CTS)    : de08c407-19b9-427d-9fe8-edf254300ca7
TenantId(CALIBER): ad912b70-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud
RoleDefName      : Owner
RoleDefName Id   : 8e3af657-a8ff-443c-a75c-2fe8c4bcb635
RoleDefName      : Contributor
RoleDefName Id   : b24988ac-6180-42a0-ab88-20f7382dd24c
RoleDefName      : Calib_Contributor_V2
RoleDefName Id   : 2ec3871a-cafd-4803-a971-3ef9e108e926
#>

<#Login-AzureRmAccount
#Get-AzureRmSubscription
Connect-AzureRmAD -confirm
Get-AzureRmProviderOperation -OperationSearchString "Microsoft.AzureActiveDirectory/*"
Get-AzureRmProviderOperation -OperationSearchString "Microsoft.Compute/virtualMachines/*/action"
Get-AzureRmProviderOperation -OperationSearchString "Microsoft.Compute/virtualMachines/*"
Get-AzureRmRoleDefinition | FT Name, Description
Get-AzureRmRoleDefinition Calib_Contributor
Get-AzureRmRoleDefinition Calib_Contributor_v3 | ConvertFrom-Json 
Get-Content C:\temp\Creating_RBAC_V1.json | ConvertFrom-Json 

Get-AzureRmRoleDefinition Calib_Contributor_v3 | ConvertTo-Json 

#>

#Select-AzureRmSubscription -SubscriptionId '8a9a4c1c-ea49-47af-a059-d790e9782847' -TenantId 'ad912b70-5e79-4058-843b-9f8f89d884d7'
Login-AzureRmAccount -SubscriptionId '8a9a4c1c-ea49-47af-a059-d790e9782847' -TenantId 'ad912b70-5e79-4058-843b-9f8f89d884d7'
Select-AzureRmSubscription -Tenant 'CALIBER'
New-AzureRmRoleDefinition -InputFile C:\5.3_RBAC_Calib_Contributor_V1.json
Get-AzureRmRoleDefinition Calib_Contributor_V1 | ConvertTo-Json




