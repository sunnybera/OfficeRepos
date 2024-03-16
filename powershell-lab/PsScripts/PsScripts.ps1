#
# Script.ps1
#
get-Module -ListAvailable

Connect-AzureRmAccount
$locName= "west europe"
Get-AzureRmVMImagePublisher -Location $locName | Select PublisherName
<# $pubName="microsoft_iot_edge"
$pubName="MicrosoftWindowsServer"
$pubName="rstudio-5237862"
#>
$pubName="paloaltonetworks"
Get-AzureRmVMImageOffer -Location $locName -PublisherName $pubName | Select Offer

$offerName="vmseries-flex"#$offerName="WindowsServer"
Get-AzureRmVMImageSku -Location $locName -PublisherName $pubName -Offer $offerName | Select Skus

$skuName="byol" #$skuName="2012-R2-Datacenter" #"2019-datacenter-with-containers"
Get-AzureRmVMImage -Location $locName -PublisherName $pubName -Offer $offerName -Sku $skuName | Select Version

