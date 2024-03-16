Connect-AzureRmAccount

Get-AzureRmPublicIpAddress | select Name, ResourceGroupName, IpAddress | Out-File -FilePath "c:\12.1_cal2020_IP-List.csv"
Get-AzureRmVM | select Name, ResourceGroupName, Location | Out-File -FilePath "c:\12.2_cal2020_VM-List.csv"
Get-AzureRmADUser | select DisplayName |  Out-File -FilePath "c:\12.3_cal2020_ADUser-List.csv"
Get-AzureRmVM -Status | Select ResourceGroupName, Name, PowerState | Where {$_.PowerState –eq ‘VM running’} | Out-File -FilePath "c:\Temp\11.4_cal2020_Process.csv"

$GuestIdentifyer = AzureAdUser.UserState -eq "Accepted"
Get-AzureRmADUser -ObjectId 1cd5a8de-ee5b-4a80-8644-aa9f8b40ae16
AzureRmAdUser.UserState -eq "Accepted"

Get-AzureADUser `
| Where-Object { $_.UserType -eq 'Guest' -and $_.UserState -eq 'PendingAcceptance' } `
| Select-Object -Property DisplayName,Mail,UserState,UserStateChangedOn `
| Sort-Object -Property DisplayName `
| Format-Table -AutoSize

### Creating Nework File Share ###

$connectTestResult = Test-NetConnection -ComputerName npcalrg003calsta.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"npcalrg003calsta.file.core.windows.net`" /user:`"Azure\npcalrg003calsta`" /pass:`"7gJdV4LmH3T3Slr23hCW+r+pHRPj89QbYj/dBqN1vIMuXHmxDXFo9Amz8lpkc/iriCqgE6HHea3hyyH4mhxHvg==`""
    # Mount the drive
    New-PSDrive -Name E -PSProvider FileSystem -Root "\\npcalrg003calsta.file.core.windows.net\filesharesouthcentralus"-Persist
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}