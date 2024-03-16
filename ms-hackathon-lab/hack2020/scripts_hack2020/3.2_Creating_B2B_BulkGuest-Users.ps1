<#******************************************************************************************************************************************
Created By    : Suman Mukhopadhyay
Created Date  : 9-May-2019
Tested By     : Sunny Bera 
Tested Date   : 16-May-2019
Description   : Script for Creating Bulk B2B Users
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

$invitations = Import-Csv "C:\temp\CALIBER 2.0 Hackathon_V2_Final.csv" 
$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo$messageInfo.customizedMessageBody = "Hello Team! The Caliber 2.0 hackathon event would like to sign You in. By providing your existing password for this e-mail account in subsequent window, you would complete the sign-in process. Please login to https://portal.azure.com if not redirected automatically."

   
foreach ($email in $invitations) {
    New-AzureADMSInvitation `
        -InvitedUserEmailAddress $email.AzTeamCommonMailId `
        -InvitedUserDisplayName $email.AzRG `
        -InviteRedirectUrl https://portal.azure.com `
        -InvitedUserMessageInfo $messageInfo `
        -SendInvitationMessage $true #<==#EDITABLE -to be made true if mail trigger not required
}


  
   

   
   
   
   
   
