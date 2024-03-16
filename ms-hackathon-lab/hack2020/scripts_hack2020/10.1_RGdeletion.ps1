Login-AzureRmAccount

$rgcsv = Import-Csv "C:\temp\sunnyrg-pending.csv" 
foreach ($item in $rgcsv) {
    $rg = $item.name
    Get-AzureRmResourceGroup -Name $rg | Remove-AzureRmResourceGroup -Verbose -Force
}
