<#
*******************************************************************************************************************************************
Description      : This script will invite B2B memberrs as per input csv.
*******************************************************************************************************************************************

Resource Type    : PaaS
Resource List    : AD Member, B2B Invitation Message to Member with invitation redeem url, 
Architecture     :
Best Practices   : Member can not be created with existing email in Directory, Invitation is set true for subscription invitation
Existing Artifact: N/A 
-------------------------------------------------------------------------------------------------------------------------
Version          : V1
Requires         : PowerShell Version 3.0 or above
Module           : Az.Resources, AzureADPreview
Account          : xxxxxxxx@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - xxxxxxxx
SubscriptionId   : xxxxxxxx-ea49-47af-a059-d790e9782847
TenantId         : xxxxxxxx-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud

-------------------------------------------------------------------------------------------------------------------------
Created By    : Sunny Bera
Created Date  : 16-April-2020
Description   : Cleaned up the existing script for Caliber 2020.Added resource lock function.Upgraded skuname=<2019-datacenter-with-containers-g2>, vmsize=<D4s_v3> for Hyper-v and IOT edge
              : functionalities
Modified By   : 
Modified Date : 
Description 

******************************************************************************************************************************************

#>

#EDITABLE - Need to provide working Domain:

Connect-AzureAD -TenantDomain "caliber2hackathon.onmicrosoft.com" 

# EDITABLE - CSV file path containing the list of invitee and corresponding email ids to be assigned:

$invitations = Import-Csv "C:\Temp\11.1_cal2020_users.csv" 
$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo 
  

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

Disconnect-AzureAD  
   

   
   
   
   
   
