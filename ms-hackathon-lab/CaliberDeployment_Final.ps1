
#***********************************************************************************#
# Powershell script for Multiple VM & Resource Group Deployments Using ARM Template #
#***********************************************************************************#


# Sign in
Write-Host "Logging in...";
Connect-AzAccount;

#Select subscription
#Write-Host "Selecting subscription '$subscriptionId'";
#Select-AzureSubscription -SubscriptionID $subscriptionId;

$resourceGroupLocation="eastus",

$AdminStorageName = "npcalsa001" 
$StorageAccountKey = (Get-AzKeyVaultSecret -VaultName caliber2 -Name StorageAccount).SecretValueText
$ContainerName = "np-cal-ctn-001"
[string]
$templateFilePath = Read-Host "Enter templtae file path"
#[string]
#$parametersFilePath = "parameters.json"

$usersList = Import-Csv "Enter CSV file path" 


foreach($row in $usersList)
{
	$resourceGroupName = $row.AzRG
    New-AzResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation

	Write-Host "Initiating deployment...";
	New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $templateFilePath;
	$CreatedVmName = Get-AzVM -ResourceGroupName $resourceGroupName
	Set-AzVMCustomScriptExtension -ResourceGroupName $resourceGroupName -Location $resourceGroupLocation -VMName $CreatedVmName.name -Name "VMConfigScript" -TypeHandlerVersion "1.1" -StorageAccountName $AdminStorageName -StorageAccountKey $StorageAccountKey -FileName "2.2_ForNewlyBuiltVM_V1.ps1" -ContainerName $ContainerName

}	