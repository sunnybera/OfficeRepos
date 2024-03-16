    
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
Account   : caliber2@caliber2hackathon.onmicrosoft.com
                   SunnyB@Cogcis.onmicrosoft.com 
                   SubscriptionName : CCS_FF_6_MSDN
                   SubscriptionId   : 5ab66322-398c-4751-b098-225402bdf7a3
                   TenantId         : b72c46a0-a269-4c0f-8e93-c736da98a9e
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
Get-AzureRmRoleDefinition owner
Get-Content C:\temp\Creating_RBAC_V1.json | ConvertFrom-Json 

#>

#Sign into Azure Powershell with your account -SubscriptionId '8a9a4c1c-ea49-47af-a059-d790e9782847' -TenantId 'ad912b70-5e79-4058-843b-9f8f89d884d7'
Login-AzureRmAccount -SubscriptionId '8a9a4c1c-ea49-47af-a059-d790e9782847' -TenantId 'ad912b70-5e79-4058-843b-9f8f89d884d7'

#Select a subscription to monitor with a budget
#Select-AzureRmSubscription -Tenant 'CALIBER'

select-AzureRmSubscription -Subscription "CCS_FF_6_MSDN"

#Create an action group email receiver and corresponding action group

$email1 = New-AzureRmActionGroupReceiver -EmailAddress sunny.bera@cognizant.com -Name EmailReceiver_admin
$ActionGroupId = (Set-AzureRmActionGroup -ResourceGroupName Sunbox -Name npcalag001 -ShortName CaliberAG -Receiver $email1).Id

#Create a monthly budget that sends an email and triggers an Action Group to send a second email. Make sure the StartDate for your monthly budget is set to the first day of the current month. Note that Action Groups can also be used to trigger automation such as Azure Functions or Webhooks.

New-AzureRmConsumptionBudget -Amount 100 -Name npcalbudget001 -Category Cost -StartDate 2020-03-17 -TimeGrain Monthly -EndDate 2022-12-31 -ContactEmail "sunny.bera@cognizant.com" -NotificationKey Key1 -NotificationThreshold 0.8 -NotificationEnabled -ContactGroup $ActionGroupId




