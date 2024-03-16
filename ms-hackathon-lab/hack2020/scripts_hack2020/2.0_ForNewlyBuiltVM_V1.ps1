<#******************************************************************************************************************************************

This script will do the following in Newly Built VMs:
a)  Will enable PS Remoting
b)  Will start File sharing 
c)  Will switch off Firewall
d)  Will install Telnet
e)  Will install IIS
f)  Will Add 2 Local Users with Admin Rights -- User IDs:  calibone, calibtwo / Password: 'Welcome@caliber2'
g)  Will disable IE Enhanced Security Configuration

Note:  Please Refer Run Book -  "Run Book-  Post-Deployment Configuration in Azure VM"
 
-------------------------------------------------------------------------------------------------------------------------
File Name        : 2.2_ForNewlyBuiltVM.ps1
Version          : 1
Requires         : PowerShell Version 3.0 or above
Environment      : Azure VM - Windows Server


Created By    : Suman Mukhopadhyay
Created Date  : 6-May-2019
Last updated Date:  June 25, 2019 (Will disable IE Enhanced Security Configuration)
Tested By     : Suman Mukhopadhyay
Tested Date   : 10-May-2019
Description   : Post Deployment Configuration Script for Newly Built Az VMs

******************************************************************************************************************************************#>
#Enabling Remote PS
#Invoke-AzureRmVMRunCommand -CommandId "EnableRemotePS" -ResourceGroupName $resourcegroup -VMName myVM1

Enable-PSRemoting -Force

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

#To Check and particular Service Status:

Get-Service "DNS Client" | select DisplayName, StartType, Status  	
Get-Service "Function Discovery Resource Publication" | select DisplayName, StartType, Status  
Get-Service "UPnP Device Host" | select DisplayName, StartType, Status
Get-Service "SSDP Discovery" | select DisplayName, StartType, Status

# Installing Telnet In Newly created Azure VM:
Import-Module servermanager

Add-WindowsFeature telnet-client
Add-WindowsFeature telnet-server

Get-Service "telnet" | Where {$_.StartType -ne "Automatic"} | Set-Service -StartupType Automatic
Get-Service "telnet" | Where {$_.status –eq 'stopped'} | Start-Service

# Installing Web Server in VM with PS (open PS in VM Server itself):
Install-WindowsFeature -name Web-Server -IncludeManagementTools

#Adding 2 Local Users (new version needs to be installed before this) with Admin Rights

$SecurePassword = ConvertTo-SecureString 'azure@2020' -AsPlainText -Force

#In case User will be able to change his password after login to VM:
New-LocalUser -AccountNeverExpires -Description "Users for Hackathon" -Name "calibone" -Password $SecurePassword -PasswordNeverExpires 
New-LocalUser -AccountNeverExpires -Description "Users for Hackathon" -Name "calibtwo" -Password $SecurePassword -PasswordNeverExpires


#In case User will not be able to change his password:
#New-LocalUser -AccountNeverExpires -Description "Users for Hackathon" -Name "calibone" -Password $SecurePassword -UserMayNotChangePassword -PasswordNeverExpires 
#New-LocalUser -AccountNeverExpires -Description "Users for Hackathon" -Name "calibtwo" -Password $SecurePassword -UserMayNotChangePassword -PasswordNeverExpires

 
Add-LocalGroupMember -Group 'Administrators' -Member ('calibone', 'calibtwo') –Verbose

Set-TimeZone -Name "India Standard Time"

#Disabling IE Enhanced Security Configuration

function Disable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 0 -Force
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 0 -Force
    Stop-Process -Name Explorer -Force
    Write-Host "IE Enhanced Security Configuration (ESC) has been disabled." -ForegroundColor Green
}
function Enable-InternetExplorerESC {
    $AdminKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A7-37EF-4b3f-8CFC-4F3A74704073}"
    $UserKey = "HKLM:\SOFTWARE\Microsoft\Active Setup\Installed Components\{A509B1A8-37EF-4b3f-8CFC-4F3A74704073}"
    Set-ItemProperty -Path $AdminKey -Name "IsInstalled" -Value 1 -Force
    Set-ItemProperty -Path $UserKey -Name "IsInstalled" -Value 1 -Force
    Stop-Process -Name Explorer -Force
    Write-Host "IE Enhanced Security Configuration (ESC) has been enabled." -ForegroundColor Green
}
function Disable-UserAccessControl {
    Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 00000000 -Force
    Write-Host "User Access Control (UAC) has been disabled." -ForegroundColor Green    
}
Disable-UserAccessControl
Disable-InternetExplorerESC


#To check Users
Get-LocalUser



