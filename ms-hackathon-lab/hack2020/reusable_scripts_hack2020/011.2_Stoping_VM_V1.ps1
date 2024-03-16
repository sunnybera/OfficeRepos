<#
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

Description      : This script connects to Azure and starts all VMs in Azure resource groups provided through CSV file.
                   You can attach a schedule to this runbook to run it at a specific time. Note that this runbook does not start
                   Azure classic VMs. Use https://gallery.technet.microsoft.com/scriptcenter/Start-Azure-Classic-VMs-86ef746b for that.
-------------------------------------------------------------------------------------------------------------------------
Resource Type    : IaaS
Resource List    : Starts Virtual Machine
Architecture     :
Best Practices   : All VMs are deployed within subscription incase CSV not found.
Existing Artifact: N/A 
-------------------------------------------------------------------------------------------------------------------------
Version          : V1
Requires         : PowerShell Version 3.0 or above
Module           : Az.Resources
Product          : Azure Active Directory
Account          : xxxxxxxx@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - xxxxxxxx
SubscriptionId   : xxxxxxxx-ea49-47af-a059-d790e9782847
TenantId         : xxxxxxxx-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud
-------------------------------------------------------------------------------------------------------------------------
Created By       : Sunny Bera
Modified Date    : 1-May-2020
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


# Variable declaration

# sign in
Write-Host "Logging in...";
#Login-AzAccount;

 
# Variable Declaration 

$usersList = Import-Csv "C:\Temp\11.3_cal2020_users.csv" 

foreach($row in $usersList) {
    
$ResourceGroupName = $row.AzRG


# If there is a specific resource group, then get all VMs in the resource group,
# otherwise get all VMs in the subscription.


if ($ResourceGroupName) 
{ 
	$VMs = Get-AzVM -ResourceGroupName $ResourceGroupName
}
else 
{ 
	$VMs = Get-AzVM
}

# Start each of the VMs

foreach ($VM in $VMs)
{
	
    Write-Output ($VM.Name + " being stopped")
    $StartRtn = $VM | Stop-AzVM -force -ErrorAction Continue

	if ($StartRtn.Status -ne 'VM Running')
	{
		# The VM stopping, so send notice
        
        Get-AzVM -ResourceGroupName $ResourceGroupName -Status | Select ResourceGroupName, Name, PowerState #| Where {$_.PowerState –eq ‘VM deallocated’} 
        
             
	}
	else
	{
		# The VM failed to start, so send notice

		Write-Output ($VM.Name + " failed to stop")
        Write-Error ($VM.Name + " failed to stop. Error was:") -ErrorAction Continue
		Write-Error (ConvertTo-Json $StartRtn.Error) -ErrorAction Continue
	}
}
}