Connect-AzureRmAccount
Install-Module AzureRMAD  # to install Azure AD 
Connect-AzureAD
Install-Module MSOnline   # to install Microsoft Online Command
Connect-MsolService


# Here converting the User "Sushma.BR@cognizant.com" (as an example) from Guest to Member

Get-AzureRmADUser -UserPrincipalName Sushma.BR_cognizant.com#EXT#@caliber2hackathon.onmicrosoft.com  # to check user

Set-MsolUser -UserPrincipalName Sushma.BR_cognizant.com#EXT#@caliber2hackathon.onmicrosoft.com -UserType Member  # to convert user type