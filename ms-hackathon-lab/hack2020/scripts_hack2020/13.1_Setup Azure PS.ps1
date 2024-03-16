<#******************************************************************************************************************************************
Custom Role Based Access creation for Users/Groups
******************************************************************************************************************************************

File Name        : 5.1_Creating_RBAC_V1
Author           : Sunny Bera
Version          : 1
Date             : 17-May-2019
Update           : 
Requires         : PowerShell Version 3.0 or above
Module           : AzureAD Version 2.0.0.155 or above
Product          : Azure Active Directory,IAM,JSON,PowerShell,RBAC 
Account          : SunnyB@Cogcis.onmicrosoft.com 
SubscriptionName : CCS_FF_6_MSDN
SubscriptionId   : 5ab66322-398c-4751-b098-225402bdf7a3
TenantId         : b72c46a0-a269-4c0f-8e93-c736da98a9e4
TenantId(CTS)    : de08c407-19b9-427d-9fe8-edf254300ca7

Account          :caliber2@caliber2hackathon.onmicrosoft.com
SubscriptionName : Microsoft Azure Enterprise - CALIBER
SubscriptionId   : 8a9a4c1c-ea49-47af-a059-d790e9782847
TenantId(CALIBER): ad912b70-5e79-4058-843b-9f8f89d884d7

Environment      : AzureCloud
RoleDefName      : Owner
RoleDefName Id   : 8e3af657-a8ff-443c-a75c-2fe8c4bcb635
RoleDefName      : Contributor
RoleDefName Id   : b24988ac-6180-42a0-ab88-20f7382dd24c
RoleDefName      : Calib_Contributor_V2
RoleDefName Id   : 2ec3871a-cafd-4803-a971-3ef9e108e926
******************************************************************************************************************************************
#>

#Stop Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

#"winrm qc /force"

# Making the below services 'Automatic' if not:

Get-Service "DNS Client" | Where {$_.StartType -ne "Automatic"} | Set-Service -StartupType Automatic
Get-Service "Function Discovery Resource Publication" | Where {$_.StartType -ne "Automatic"} | Set-Service -StartupType Automatic
Get-Service "UPnP Device Host" | Where {$_.StartType -ne "Automatic"} | Set-Service -StartupType Automatic
Get-Service "SSDP Discovery" | Where {$_.StartType -ne "Automatic"} | Set-Service -StartupType Automatic

# Starting Stopped Services:

Get-Service "DNS Client" | Where {$_.status –eq 'stopped'} | Start-Service  	
Get-Service "Function Discovery Resource Publication" | Where {$_.status –eq 'stopped'} | Start-Service  
Get-Service "UPnP Device Host" | Where {$_.status –eq 'stopped'} | Start-Service 
Get-Service "SSDP Discovery" | Where {$_.status –eq 'stopped'} | Start-Service 

#To Check and particular Servicce Status:

Get-Service "DNS Client" | select DisplayName, StartType, Status  	
Get-Service "Function Discovery Resource Publication" | select DisplayName, StartType, Status  
Get-Service "UPnP Device Host" | select DisplayName, StartType, Status
Get-Service "SSDP Discovery" | select DisplayName, StartType, Status

# Now we are installing Telnet In Newly created Azure VM:
Import-Module servermanager

Add-WindowsFeature telnet-client
Add-WindowsFeature telnet-server

Get-Service "telnet" | Where {$_.StartType -ne "Automatic"} | Set-Service -StartupType Automatic
Get-Service "telnet" | Where {$_.status –eq 'stopped'} | Start-Service

# Installing Web Server in VM with PS (open PS in VM Server itself):
Install-WindowsFeature -name Web-Server -IncludeManagementTools

#Adding one Local User (new version needs to be installed before this) with Admin Rights (User ID:  Cal2User1, Cal2User2) AND Password:  "Welcomes@2019"

$SecurePassword = ConvertTo-SecureString 'Welcome@555' -AsPlainText -Force

New-LocalUser -AccountNeverExpires -Description "Users for Hackathon" -Name "Calib-01" -Password $SecurePassword -UserMayNotChangePassword -PasswordNeverExpires 
New-LocalUser -AccountNeverExpires -Description "Users for Hackathon" -Name "Calib-02" -Password $SecurePassword -UserMayNotChangePassword -PasswordNeverExpires 

Add-LocalGroupMember -Group 'Administrators' -Member ('Calib-01','Calib-02') –Verbose

#To check Users
Get-LocalUser


<# https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=azps-2.8.0&viewFallbackFrom=azurermps-5.5.0
#>
get-Module -ListAvailable
Enable-PSRemoting -Force
$PSVersionTable.PSVersion

# Install az module
Install-Module -Name Az -AllowClobber -Scope CurrentUser
Import-Module -Name Az
Set-ExecutionPolicy unrestricted

#Import Azure RM Module
Install-Module -Name AzureRm -AllowClobber -Scope CurrentUser
Import-Module -Name AzureRm

Install-PackageProvider -Name NuGet -Force
Install-PackageProvider -Name NuGetProvider -MinimumVersion 2.8.5.201 -Force
Import-PackageProvider -Name NuGet -RequiredVersion 2.8.5.208

Install-Module -Name AzureRm -AllowClobber
Import-Module -Name AzureRm

Get-PackageProvider -ListAvailable
Import-PackageProvider -Name PowerShellGet -MinimumVersion 1.0.0.1 -Force
Install-Module -Name Az -AllowClobber -Scope CurrentUser
Get-InstalledModule -Name Az -AllVersions | select Name,Version
Install-Module AzureADPreview

Set-ItemProperty -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NetFramework\v4.0.30319' -Name 'SchUseStrongCrypto' -Value '1' -Type DWord
[Net.ServicePointManager]::SecurityProtocol

msiexec.exe /package PowerShell-<version>-win-<os-arch>.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1

Install-Module MSOnline -AllowClobber -Scope CurrentUser

Get-ExecutionPolicy RemoteSigned
Set-PSRepository cmdlet 

$PSise.Options.RestoreDefaults()
$PSise.Options.RestoreDefaultConsoleTokenColors()
$PSise.Options.RestoreDefaultTokenColors()
$PSise.Options.RestoreDefaultXMLTokenColors()

register-packagesource -Name NuGet -ProviderName NuGet -location https://www.nuget.org/api/v2/
Install-Module -Name PackageManagement
Register-PSRepository -default -verbose
$path = 'C:\Program Files (x86)\PackageManagement\ProviderAssemblies\nuget\2.8.5.208\Microsoft.PackageManagement.NuGetProvider.dll'
Import-PackageProvider $path -Verbose
Get-PackageProvider

$wc = New-Object System.Net.WebClient
$wc.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials

Import-PackageProvider -Name NuGetProvider

$sourceNugetExe = "https://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
$targetNugetExe = "$path\nuget.exe"
Invoke-WebRequest $sourceNugetExe -OutFile $targetNugetExe
Set-Alias nuget $targetNugetExe -Scope Global -Verbose

#https://docs.microsoft.com/en-us/information-protection/develop/concept-authentication-acquire-token-ps
#https://docs.microsoft.com/en-us/information-protection/develop/setup-configure-mip
install-module -name adal.ps
Install-Module -name AzureServicePrincipalAccount -AllowClobber
Import-Module -name adal.ps
Import-Module -name AzureServicePrincipalAccount


#Uninstall-AzureRm

Get-Module -Name AzureRm -ListAvailable
Get-Module -ListAvailable AzureRM*
clear
foreach ($module in (Get-Module -ListAvailable AzureRM*).Name |Get-Unique) {
   write-host "Removing Module $module"
   Uninstall-module $module -Force -verbose 
}

#Admin Privilege required, mail to itamsupportteam@cognizant.com
#https://techcommunity.microsoft.com/t5/windows-powershell/trying-to-install-module-azuread-but-get-psrepository-quot/m-p/202819
Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
Register-PSRepository -Default -Verbose
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
Connect-AzureRmAccount
disconnect-AzureRmAccount

Get-AzureRmMarketplaceTerms -Publisher "microsoft_iot_edge" -Product "iot_edge_vm_ubuntu" -Name "ubuntu_1604_edgeruntimeonly" | Set-AzureRmMarketplaceTerms -Accept

#Install Azure CLI on Windows: 'https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-powershell'

$DownloadFile = 'C:\Temp\AzureCLI.msi'
Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'; rm .\AzureCLI.msi
Start-Process Powershell.exe

Install-Module SpeculationControl -AllowClobber -Scope CurrentUser