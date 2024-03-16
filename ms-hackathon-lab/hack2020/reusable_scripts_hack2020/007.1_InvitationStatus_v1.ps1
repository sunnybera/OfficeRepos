<#-----------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

Description      : This script connects to Azure AD and starts pulling existing AD Users provided through CSV file.
                   Preferably to be used to check on Guest/Member invitation state interms of 'Accepted' or 'PendingAcceptance'. 
-------------------------------------------------------------------------------------------------------------------------
Resource Type    : IaaS
Resource List    : Get ADUser details
Architecture     :
Best Practices   : Erroneous or invalid ADUser names are skipped incase wrongly mentioned in CSV.
Existing Artifact: N/A 
-------------------------------------------------------------------------------------------------------------------------
Version          : V1
Requires         : PowerShell Version 3.0 or above
Module           : AzureADPreview
Product          : Azure Active Directory
Account          : xxxxxxxx@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - xxxxxxxx
SubscriptionId   : xxxxxxxx-ea49-47af-a059-d790e9782847
TenantId         : xxxxxxxx-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud
-------------------------------------------------------------------------------------------------------------------------
Created By       : Sunny Bera
Modified Date    : 19-May-2020
Description      : created script for Caliber 2020 event
Modified By      : 
Modified Date    : 
Description      : 
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

param (
    [Parameter(Mandatory=$false)] 
    [String]  $AzureCredentialAssetName = 'AzureCredential',
        
    [Parameter(Mandatory=$false)]
    [String] $AzureSubscriptionIdAssetName = 'AzureSubscriptionId',

    [Parameter(Mandatory=$false)] 
    [String] $ResourceGroupName
)

# Returns strings with status messages
[OutputType([String])]



# Connect to Azure and select the subscription to work against
$Cred = Get-AutomationPSCredential -Name $AzureCredentialAssetName -ErrorAction Stop

$null = Add-AzureRmAccount -Credential $Cred -ErrorAction Stop -ErrorVariable err
if($err) {
	throw $err
}

$SubId = Get-AutomationVariable -Name $AzureSubscriptionIdAssetName -ErrorAction Stop
#>



# Login to Azure AD

Connect-AzureAD -TenantDomain "caliber2hackathon.onmicrosoft.com"


# Variable Declaration 

$userList = Import-Csv "C:\temp\11.3_cal2020_users.csv" 

foreach ($row in $userList) {
    $ADUser = $row.AzRG   
    $Role = Get-AzRoleAssignment -ResourceGroupName $ADUser 
    foreach($user in  $Role){
    #Get acceptance status
        Get-AzureADUser -ObjectId $user.ObjectId | Select-Object -Property DisplayName, Mail, UserState

    }
   
    }
    
Disconnect-AzureAD

