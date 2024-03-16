<#
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

Description      : This script connects to Azure and disables auto shut down (if configured) for all VMs 
                   in Azure resource groups provided through CSV file.
-------------------------------------------------------------------------------------------------------------------------
Resource Type    : IaaS
Resource List    : Disable Auto Shut Down for Virtual Machine
Architecture     :
Best Practices   : Disable Auto Shut Down for all VMs within subscription incase CSV not found.
Existing Artifact: N/A 
-------------------------------------------------------------------------------------------------------------------------
Version          : V2
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
Modified Date    : 6-May-2020
Description      : created script for Caliber 2020 event
Modified By      : 
Modified Date    : 
Description      : 
-------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------

param (
    [Parameter(Mandatory=$false)] 
    [String] $ResourceGroupName
)


# sign in
Write-Host "Logging in..."
$runAsConnectionProfile = Get-AutomationConnection -Name "AzureRunAsConnection"
Add-AzAccount -ServicePrincipal -TenantId $runAsConnectionProfile.TenantId -ApplicationId $runAsConnectionProfile.ApplicationId `
-CertificateThumbprint $runAsConnectionProfile.CertificateThumbprint | Out-Null
Write-Output "Authenticated with Automation Run As Account."
#>

# sign in

    Write-Host "Logging in...";
    #Login-AzAccount;

# Variable declaration
 
    $usersList = Import-Csv "C:\Temp\11.5_cal2020_users.csv" 
    $ShutdownTime = 2300
    $TimeZone = "India Standard Time" 
    $SubscriptionId = (Get-AzContext).Subscription.Id

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
	# Variable Declaration for Disabling Auto shutdown
    
    $VmName = $VM.Name
    $VMResourceId = (Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName).Id
    $ScheduledShutdownResourceId = "/subscriptions/$SubscriptionId/resourceGroups/$ResourceGroupName/providers/microsoft.devtestlab/schedules/shutdown-computevm-$VmName"
    $Region = $VM.Location
    
    $Properties = @{}
    $Properties.Add('status', 'Disabled')
    $Properties.Add('taskType', 'ComputeVmShutdownTask')
    $Properties.Add('dailyRecurrence', @{'time'= $ShutdownTime})
    $Properties.Add('timeZoneId', $TimeZone)
    $Properties.Add('notificationSettings', @{status='Disabled'; timeInMinutes=15})
    $Properties.Add('targetResourceId', $VMResourceId)

    Write-Output ("Disabling Auto shutdown for " + $VmName )
    
    New-AzResource -Location $Region -ResourceId $ScheduledShutdownResourceId -Properties $Properties -Force
    
	
if ($Properties.status -eq 'Disabled')
	{
		# The Auto shutdown is disabled, so send notice
        
        Write-Output ("Disabled Auto shutdown for " + $VmName ) 
        
	}
else
	{
		# The Auto shutdown disable failed, so send notice

		Write-Output ($VmName + " failed to Disable Auto Shutdown")
        Write-Error ($VmName + " failed to disable Auto Shutdown. Error was:") -ErrorAction Continue
		
	}

}
}