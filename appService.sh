#!/bin/bash

# Check if number of arguments is equal to 5
if [ $# -ne 5 ]; then
    echo "Invalid number of arguments.."
    exit 1
fi

resourceGroupName=$1
templateFile=$2
appServicePlan=$3
appService=$4
vnetName=$5

# Print arguments
echo "In appService.sh"
echo "Resource Group : " $resourceGroupName
echo "Template file : " $templateFile
echo "appServicePlan : " $appServicePlan
echo "appService : " $appService
echo "vnetName : " $vnetName

# Create AppService
az deployment group create --resource-group $resourceGroupName --template-file $templateFile --parameters appServicePlan=$appServicePlan appService=$4 vnetName=$vnetName &
wait $!

az webapp config appsettings set -g $resourceGroupName  -n $appService --settings WEBSITE_Load_Certificates=* &
wait $!

az webapp config appsettings set -g $resourceGroupName  -n $appService --settings WEBSITE_TIME_ZONE="India Standard Time" &
wait $!

az webapp config appsettings set -g $resourceGroupName  -n $appService --settings WEBSITE_VNET_ROUTE_ALL=1 &
wait $!

az webapp config appsettings delete --name $appService --resource-group $resourceGroupName --setting-names WEBSITE_NODE_DEFAULT_VERSION &
wait $!