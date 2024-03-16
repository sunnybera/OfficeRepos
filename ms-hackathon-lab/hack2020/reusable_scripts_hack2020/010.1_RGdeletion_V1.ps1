<#
-------------------------------------------------------------------------------------------------------------------------
Description      : This script will take input from csv file and accordingly delete Resource groups and 
                 : static public IPs for each team 
-------------------------------------------------------------------------------------------------------------------------
Resource Type    : IaaS
Resource List    : Deletes Resource Group with all its content. RG lock needs to be removed if any 
Architecture     :
Best Practices   : 
Existing Artifact: N/A 
-------------------------------------------------------------------------------------------------------------------------
Version          : V1
Requires         : PowerShell Version 3.0 or above
Module           : Az.Resources
Account          : xxxxxxxx@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - CALIBER
SubscriptionId   : xxxxxxxx-ea49-47af-a059-d790e9782847
TenantId         : xxxxxxxx-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud
-------------------------------------------------------------------------------------------------------------------------
Created By   : Sunny Bera
Created Date : 13-March-2020
Description  : Cleaned up the existing script for Caliber 2020. 
Modified By  :
Modified Date:
Description  :
-------------------------------------------------------------------------------------------------------------------------
#>

Login-AzAccount

$rgcsv = Import-Csv "C:\Temp\11.1_cal2020_users.csv" 
foreach ($item in $rgcsv) {
    $rg = $item.name
    Get-AzureRmResourceGroup -Name $rg | Remove-AzureRmResourceGroup -Verbose -Force
}

Disconnect-AzAccount
