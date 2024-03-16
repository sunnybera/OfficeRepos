$rg = Import-Csv "C:\temp\CALIBER 2.0 Hackathon.csv" 
foreach ($row in $rg) {
    $rg = $row.AzRG   
    $users = Get-AzureRmRoleAssignment -ResourceGroupName $rg 
    foreach($user in  $users){
    # Add user to role
        Get-AzureADUser -ObjectId $user.ObjectId | Where-Object { $_.UserType -eq 'Guest' -and $_.UserState -eq 'PendingAcceptance' }`
| Select-Object -Property DisplayName, Mail, UserState 
    }
}
