#
# Script.ps1
#
get-Module -ListAvailable
$KAUSTuser='admin@kaustctsaz.onmicrosoft.com'
$KAUSTcred= 'Jan21@cogcis'
$KAUSTsub = "KAUSTCSPPRD" #"KAUSTCSPNONPRD"
$KAUSTsubID= "610b4239-2671-4780-93cf-8211107d16bf"
Connect-AzureRmAccount -Subscription $KAUSTsub

$locName= "west europe"
Get-AzureRmVMImagePublisher -Location $locName | Select PublisherName
<# $pubName="microsoft_iot_edge"
$pubName="MicrosoftWindowsServer"
$pubName="rstudio-5237862"
$pubName="suse"

#>
$pubName="paloaltonetworks"
Get-AzureRmVMImageOffer -Location $locName -PublisherName $pubName | Select Offer

<#
#$offerName="WindowsServer",
$offerName="vmseries-flex",
$offerName="vmseries1"
#>

$offerName="vmseries-flex"  #"sles-sap-15-sp1" 
Get-AzureRmVMImageSku -Location $locName -PublisherName $pubName -Offer $offerName | Select Skus

<#$skuName="2012-R2-Datacenter",
$skuName="2019-datacenter-with-containers",
$skuName="byol" 
#>

$skuName= "byol" #"gen1"
Get-AzureRmVMImage -Location $locName -PublisherName $pubName -Offer $offerName -Sku $skuName | Select Version

Get-AzureRmMarketplaceTerms -Publisher "paloaltonetworks" -Product "vmseries1" -Name "byol" | Set-AzureRmMarketplaceTerms -Accept #vmseries-flex,vmseries1

Disconnect-AzureRmAccount