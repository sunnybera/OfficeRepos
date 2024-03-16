
<#
******************************************************************************************************************************************
---------------------------------------------------------------------------------------------------------------------------------------------
Description      : Powershell script for Multiple Resource Group (RG) deployments and resopurce generation inside each RG Using ARM Template: 
				 :	1. script would create Vnet and subnet if not already exisiting					 
				 :	2. script will create the VMs and run Post Deployment Script in Newly Built VMs
				 :	3. script will create B2B memberrs as per input csv. Also invitation mail triggered to users.
				 :	4. script will assign subscription and directory role to users at defined scope in one-to-one mapping. 
                 :		Username and Resource group pair to be fed from CSV file.
---------------------------------------------------------------------------------------------------------------------------------------------
Resource Type    : SaaS, PaaS
Resource List    : NIC, storage Account, VM, OS Disk, VM custom Extentention,
				 : AD Member creation, B2B Invitation Message to Member with invitation redeem url, 
				 : AD Member subscription/role assignment to Resource Group/subscription scope, Directory role assignment to Member
Architecture     : N/A
Best Practices   : Member can not be created with existing email in Directory, Invitation can be set false incase only members to be created
				 : Users with existing subscription and directory role asignment are skipped   
Existing Artifact: N/A 
---------------------------------------------------------------------------------------------------------------------------------------------
Version          : V1
Requires         : PowerShell Version 3.0 or above
Module           : Az.Resources, AzureADPreview, AzureAD Version 2.0.0.155 or above
Account          : xxxxxxxx@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - xxxxxxxx
SubscriptionId   : xxxxxxxx-ea49-47af-a059-d790e9782847
TenantId         : xxxxxxxx-5e79-4058-843b-9f8f89d884d7
Environment      : AzureCloud
---------------------------------------------------------------------------------------------------------------------------------------------
Created By    : Sunny Bera
Created Date  : 16-May-2020
Description   : Cleaned up the existing script for Caliber 2020.
Modified By   : 
Modified Date : 
Description 

******************************************************************************************************************************************
#>

# Sign in
Write-Host "Logging in...";
#Connect-AzureRmAccount;
#Connect-AzureAD -TenantDomain "caliber2hackathon.onmicrosoft.com"

$resourceGroupLocation= "eastus"
$AdminStorageName = "npcalsa001" 
$StorageAccountKey = (Get-AzureKeyVaultSecret -VaultName caliber2 -Name StorageAccount).SecretValueText
$ContainerName = "np-cal-ctn-001"
[string]
$templateFilePath = "C:\Temp\CreateVM_V2.json" #Read-Host "Enter templtae file path"
#[string]
#$parametersFilePath = "parameters.json"
$usersList = Import-Csv "C:\Temp\11.2_cal2020_users.csv" 
$RoleDefinitionName = "Calib_Contributor_V2"
$DirectoryRoleName = "Application Administrator"
$SubscriptionId = (Get-AzureRmContext).Subscription.Id
$messageInfo = New-Object Microsoft.Open.MSGraph.Model.InvitedUserMessageInfo 


foreach($row in $usersList)
{
	$resourceGroupName = $row.AzRG
	Write-Output ($resourceGroupName + " being created")
    New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation

	Write-Host "Initiating VM deployment...";
	New-AzureRmResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath;
	
	$CreatedVmName = Get-AzureRmVM -ResourceGroupName $resourceGroupName
	Write-Host $CreatedVmName "is now getting POST-Deployment Configuration"
	Set-AzureRMVMCustomScriptExtension -ResourceGroupName $resourceGroupName -Location $resourceGroupLocation -VMName $CreatedVmName.name -Name "VMConfigScript" `
	-TypeHandlerVersion "1.1" -StorageAccountName $AdminStorageName -StorageAccountKey $StorageAccountKey -FileName "2.2_ForNewlyBuiltVM_V1.ps1" -ContainerName $ContainerName

	Write-Host "Locking resource group" $resourceGroupName
    New-AzureRmResourceLock -LockName LockGroup -LockLevel CanNotDelete -ResourceGroupName $resourceGroupName -force

	<### Creating B2B members as per input csv. Also invitation mail triggered to users ###

	#Connect-AzureAD -TenantDomain "caliber2hackathon.onmicrosoft.com" 
	#foreach ($email in $usersList) {
	#>

    $messageInfo.customizedMessageBody = "You are invited to Caliber 2020 hackathon event.By providing your existing password for this e-mail account you would complete the
	sign-in process to Azure.Please use only your Team Resource Group $resourceGroupName for any Azure resource/service deployments and VM access."

    New-AzureADMSInvitation `
        -InviteRedirectUrl https://portal.azure.com `
        -InvitedUserDisplayName $resourceGroupName `
        -InvitedUserEmailAddress $row.AzTeamCommonMailId1 `
        -InvitedUserMessageInfo $messageInfo `
        -InvitedUserType Member `
        -SendInvitationMessage $false ` #<==#EDITABLE -to be made true/false if mail trigger required/not required respectively. Can be eliminated if request need not to be sent
           
    
	<### Assigning subscription and directory role to users at defined scope in one-to-one mapping. Username and Resource group pair to be fed from CSV file.
	# Write-Output "Getting User info from AD for $userName"
	#>
		$userName = $resourceGroupName
		$AdUser = Get-AzureADUser -SearchString $resourceGroupName
		$AdUserId = $AdUser.ObjectId     
		Write-Output "Getting User info from AD for $userName"
		$AdUser = Get-AzureRmADUser -SearchString $userName
		$AdUserId = $AdUser.Id 
		Write-Output "Assigning Role for user ID $AdUserId"
		New-AzureRmRoleAssignment -ObjectId $AdUserId -RoleDefinitionId $RoleDefinitionId -Scope /subscriptions/$SubscriptionId
		Write-Output "RoleAssignment completed for $userName"


Write-Host "Directory Role Assignment started for $userName"

# Fetch User Account Administrator role instance.
$DirectoryRole = Get-AzureADDirectoryRole | Where-Object {$_.displayName -eq $DirectoryRoleName}

# Add user to role
Add-AzureADDirectoryRoleMember -ObjectId $DirectoryRole.ObjectId -RefObjectId $AdUserId

Write-Host "Directory Role Assignment completed for $userName"

#Disconnect-AzureAD

}	

#Logout-AzureRmAccount
