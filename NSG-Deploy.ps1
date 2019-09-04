$user = "sunnyb@cogcis.onmicrosoft.com"
$token = "3dvqcn7yfoanm6xmjs7njln7tdemgkb4uybaag4fcizkkziyqhfa"
$organization = "SunnyB0779"
$project = "SunBi"
$repoId = "SunBi"

$csvfilepath = "AddEditNSG.csv"
$downloadpath = "c:/repo/AddEditNSG.csv"
mkdir "c:/repo" -Force
$base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $user,$token)))
$uri = "https://dev.azure.com/$($organization)/$($project)/_apis/git/repositories/$($repoId)/items?path=$($csvfilepath)&download=true&api-version=5.0-preview.1"
Invoke-RestMethod -Uri $uri -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)}  -OutFile $downloadpath

$path = "c:/repo/AddEditNSG.csv"

$NSG_Rules = Import-Csv $Path 

foreach($rule in $NSG_Rules) {
    
   New-AzureRmNetworkSecurityGroup -Name $rule.NSGName -ResourceGroupName $rule.RGName -Location $rule.Location -Force
}

foreach($rule in $NSG_Rules) {
    
   $nsg = Get-AzureRmNetworkSecurityGroup -Name $rule.NSGName -ResourceGroupName $rule.RGName

   $nsg | Add-AzureRmNetworkSecurityRuleConfig -Name $rule.Name -Description $rule.Description `
    -Protocol $rule.Protocol -SourcePortRange $rule.SourcePortRange.Split(", ") -DestinationPortRange $rule.DestinationPortRange.Split(", ")  `
    -SourceAddressPrefix $rule.SourceAddressPrefix.Split(", ") -DestinationAddressPrefix $rule.DestinationAddressPrefix.Split(", ") `
    -Access $rule.Access -Priority $rule.Priority -Direction $rule.Direction -ErrorAction SilentlyContinue
    Set-AzureRmNetworkSecurityGroup -NetworkSecurityGroup $nsg
}
