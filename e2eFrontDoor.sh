#!/bin/bash

resourceGroupName=$1
appServicePlan=$2
appServiceName=$3
zoneName=$4
backendPoolName=$5
vnetName=$6
appServiceNameLowerCase=${appServiceName,,}

echo "============================================================================================================================"

echo "Executing e2eFrontDoor.sh"
echo "resourceGroupName : $resourceGroupName"
echo "appServicePlan : $appServicePlan"
echo "appServiceName : $appServiceName"
echo "zoneName : $zoneName"
echo "backendPoolName : $backendPoolName"
echo "vnetName : $vnetName"
echo "appServiceNameLowerCase : $appServiceNameLowerCase"
echo "domainName : $domainName"

echo "============================================================================================================================"

echo "Creating app service..."
./appService.sh $resourceGroupName appService.json $appServicePlan $appServiceName $vnetName &
wait $!
echo "Done creating app service..."

echo "============================================================================================================================"

echo "Creating DNS recordset..."
./createDNSRecordSet.sh $resourceGroupName $zoneName $appServiceName &
wait $!
echo "Done creating DNS recordset..."

echo "============================================================================================================================"

echo "Creating Front door..."
./createFrontDoor.sh $resourceGroupName frontDoorARMTemplate.json $appServiceName $backendPoolName $appServiceNameLowerCase'.azurewebsites.net' & 
wait $!
echo "Done creating Front door..."

echo "============================================================================================================================"


