trigger:
- '*'
 
pool:
  vmImage: 'windows-latest'  # You can choose the appropriate agent image
 
steps:
- powershell: |
   # Authenticate to Azure
   # Connect-AzAccount -ServicePrincipal -Tenant $env:tenantId -ApplicationId $env:servicePrincipalId -CertificateThumbprint $env:servicePrincipalCert -ServicePrincipalName $env:servicePrincipalName
   
         # PowerShell script to upload secrets from a CSV file to Key Vault
    $csvFilePath = "$(System.ArtifactsDirectory)/repos/mhc_aks_secrets.csv"  # Replace with the actual path to your CSV file
    $keyVaultName = "MHC-KV-EUS-001"  # Replace with Key Vault name
    $resourceGroupName = "MHC-RG-EUS-AKSPEGA-006"  # Replace with resource group name
 
    
    # Read and upload secrets from the CSV file
    # install-module az -force -scope currentuser
    Import-Csv $csvFilePath | ForEach-Object {
        $secretName = $_.Access_Key
        $secretValue = $_.Access_Secret
        $secret = convertto-securestring -string $secretValue -asplaintext -force
        Set-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretName -SecretValue $secret
        
    }