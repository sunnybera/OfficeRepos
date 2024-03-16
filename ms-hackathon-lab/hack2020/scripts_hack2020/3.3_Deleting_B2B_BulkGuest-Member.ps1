<#
*******************************************************************************************************************************************
This script will delete B2B guest users / members as per input csv.
*******************************************************************************************************************************************

File Name        : 3.2_Creating_B2B_BulkGuestUsers
Version          : 1.1
Requires         : PowerShell Version 3.0 or above
Module           : AzureAD Version 2.0.0.155 or above
Product          : Azure Active Directory
Account          : caliber2@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - CALIBER
SubscriptionId   : 8a9a4c1c-ea49-47af-a059-d790e9782847
TenantId         : ad912b70-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud
------------------------------------------------------------------------------------------------------------------------
Created By    : Sunny Bera
Created Date  : 17-Mar-2020
Tested By     : Sunny Bera 
Tested Date   : 17-Mar-2020
Description   : Script added to delete user type
******************************************************************************************************************************************#>
<#

Login-AzureRmAccount
Get-AzureRmSubscription

#Module requires Admin priviledge to install following PS Module:  

Install-Module AzureADPreview -Scope CurrentUser

#>

#EDITABLE - Need to provide working Domain:

Connect-AzureAD -TenantDomain "caliber2hackathon.onmicrosoft.com" 

# EDITABLE - CSV file path containing the list of invitee and corresponding email ids to be assigned:

$ADUserList = Import-Csv "C:\11.3_cal2020_users.csv" 
   

foreach ($user in $ADUserList) {
    
    $userName = $user.AzRG
    Write-Output "Getting User info from AD for $userName"
    $AdUser = Get-AzureRmADUser -SearchString $userName
    $AdUserId = $AdUser.Id 
    Write-Output "Deleting User for user ID $AdUserId"
    Remove-AzureADUser `
        -ObjectId $AdUserId
    Write-Output "Deletion completed for $userName"
    
      
}

  
   

   
   
   
   
   
