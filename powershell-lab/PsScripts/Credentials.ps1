# KAUST
<#
#KAUSTCTS CSP Subscripton
$KaustAdmin='admin@kaustctsaz.onmicrosoft.com'
$KaustAdminCred= 'May2023@cogcis'
    $KaustOwner='sunnyb@kaustctsaz.onmicrosoft.com'
    $KaustOwnerCred= 'Jun2023@cogcis'

$Kaustdomain='beras@kaustcts.com'
$KaustdomainCred= 'Jul2023@cogcis'

$KaustPrdSub = "KAUSTCSPPRD" 
$KaustPrdSubID= "610b4239-2671-4780-93cf-8211107d16bf"
$KaustNprdSub = "KAUSTCSPNONPRD" 
$KaustPrdSubID= "7fd4e873-2346-45e4-9931-944d6fca04dd"

$CSPuser= 'sunny.bera@cognizantCSPUAE.onmicrosoft.com'
$CSPcred= 'Jun2023@cogcis'
$KaustTenantID= "3d585fdc-226a-4314-b112-31cdfe876ec5"
#>

#CTS Login
<#
$CTSuser='243060@cognizant.com'
$CTScred= 'Nov2023@cogcis'/121246
#>

# GIT Subscription
<#$GitUrl= 'https://github.com/sunnybera'
$GitEmail= 'sunny.bera@yahoo.co.in'
$GitHubUser='sunnybera@github.com'
$GitHubCred= 'Sun1ly4san'
$GitHubToken="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"
#>

#DOCKER Subscription
<#$DockerUrl= 'https://hub.docker.com/u/sunnybera'
$DockerEmail= 'sunny.bera@yahoo.co.in'
$DockerUser='sunnybera'
$DockerCred= 'beras@cis'
#>

# CIS Subscription
<#
$CISTenantID1='188285f7-8f1e-4c0d-a0bc-797e3e38c5b3' #Cognizant Infrastructure Services, cogcis.onmicrosoft.com

$CISTenantID2='b72c46a0-a269-4c0f-8e93-c736da98a9e4'
$CISsubName = "CCS_FF_6_MSDN"
$CISsubID= '5ab66322-398c-4751-b098-225402bdf7a3'
$CISuser='sunnyb@cogcis.onmicrosoft.com'
$CIScred= 'Nov2023@cis'
    $AgentPoolName='sunbox-agentpool'
    $sunbox0agentpool0pat='qjsw76zf7ta332s7xf3wgs24lkeddz732g46i266fzuga2fhxtoq'
    $sunnybDomainUser='beras@sunnybera.onmicrosoft.com'
    $sunnybDomainCred= 'Nov2023@cis'
#>

***************************************************
Get-AzADUser
Connect-AzAccount -Tenant $CISTenantID2
Get-AzSubscription -TenantId $CISTenantID2
Get-AzContext
Set-AzContext -SubscriptionId $CISsubID

Select-AzureSubscription -Default -SubscriptionId $CISsubID
Set-AzureProfile -Default

az login

<#azurevm image list --offer 'sles-sap-15-sp2' --all --output table

get-azurevm -ServiceName Sunboxvm -Name Sunboxvm

az vm start -g np-dlc-rg-001 -n Sunboxvm

Get-AzMarketplaceTerms -Publisher "paloaltonetworks" -Product "vmseries-flex" -Name "byol" | Set-AzMarketplaceTerms -Accept #vmseries-flex,vmseries1

$BillName="D0700037X4"
$ResourceGuid = "0bd59a05-322a-4a1a-bf61-00b66cef0b2a"

Get-AzConsumptionUsageDetail -IncludeMeterDetails -IncludeAdditionalProperties -BillingPeriodName $BillName | Where-Object {$_.SubscriptionGuid -eq (Get-AzContext).Subscription.Id} | Where-Object {$_.MeterId -eq $ResourceGuid} | Select-Object -Property InstanceId -Unique #

Get-AzConsumptionUsageDetail -StartDate 2020-01-01 -EndDate 2020-01-31 -Top 10

Get-AzVM -Status | Select ResourceGroupName, Name, PowerState | Out-File -FilePath "c:\tmp\11.4_VM_Prod.csv"

Get-AzVM -Status | Select ResourceGroupName, Name, PowerState | Out-File -FilePath "c:\tmp\11.4_VM_Non-Prod.csv"

Get-AzVM -Status | Select ResourceGroupName, Name, PowerState | Where {$_.PowerState –eq ‘VM running’} | Out-File -FilePath "c:\tmp\11.4_VM_Running.csv"

Get-AzVM -Status | Select ResourceGroupName, Name, PowerState | Where {$_.PowerState –eq ‘VM deallocated’} | Out-File -FilePath "c:\tmp\11.4_VM_Stopped.csv"

az extension add --name aem
az vm aem set -g AZ_RG_WE_SAP_WD_NPRD -n wazwdd --install-new-extension

azcopy ?sv=2020-08-04&ss=b&srt=c&sp=rwlacitfx&se=2021-12-06T15:28:33Z&st=2021-12-05T15:28:33Z&spr=https&sig=YQckAopb1fuVPreS2gZDxEB1KxTm0cY%2Bv8DWu2Mgml8%3D
Get-InstalledModule
Uninstall-AzureRm

Disconnect-AzAccount
Connect-AzureAD 

#>