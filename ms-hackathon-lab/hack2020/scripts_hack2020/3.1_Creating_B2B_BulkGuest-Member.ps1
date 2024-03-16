<#
*******************************************************************************************************************************************
This script will create B2B guest users as per input csv. Also invitation mail triggered to users
*******************************************************************************************************************************************

File Name        : 3.1_Creating_B2B_BulkGuestUsers
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
Created By    : Suman Mukhopadhyay
Created Date  : 9-May-2019
Tested By     : Sunny Bera 
Tested Date   : 16-May-2019
Description   : Script for Creating Bulk B2B Users

------------------------------------------------------------------------------------------------------------------------
Created By    : Sunny Bera
Created Date  : 14-Mar-2020
Tested By     : Sunny Bera 
Tested Date   : 14-Mar-2020
Description   : Script addedfor invited user type
******************************************************************************************************************************************#>
<#

Login-AzureRmAccount
Get-AzureRmSubscription

#Module requires Admin priviledge to install following PS Module:  

Install-Module AzureADPreview -Scope CurrentUser

#>

#EDITABLE - Need to provide working Domain:

Connect-AzureAD -TenantDomain "sunnybera.onmicrosoft.com" 

# EDITABLE - CSV file path containing the list of invitee and corresponding email ids to be assigned:

$invitations = Import-Csv "C:\temp\11.4_cal2020_users.csv" 
$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo 
#$messageInfo.customizedMessageBody = "You are invited to Caliber 2020 hackathon event.By providing your existing password for this e-mail account you would complete the sign-in process to Azure. Please deploy/access the Resources."
   

foreach ($email in $invitations) {
    
    $AzRG = $email.AzRG
    $messageInfo.customizedMessageBody = "You are invited to Caliber 2020 hackathon event.By providing your existing password for this e-mail account you would complete the sign-in process to Azure.Please use only your Team Resource Group $AzRG for any Azure resource/service deployments and VM access."

    New-AzureADMSInvitation `
        -InviteRedirectUrl https://portal.azure.com `
        -InvitedUserDisplayName $email.AzRG `
        -InvitedUserEmailAddress $email.AzTeamCommonMailId1 `
        -InvitedUserMessageInfo $messageInfo `
        -InvitedUserType Member `
        -SendInvitationMessage $true ` #<==#EDITABLE -to be made true/false if mail trigger required/not required respectively
        
        
        
        
}

  
   

   
   
   
   
   
