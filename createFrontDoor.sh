#!/bin/bash

# Check if number of arguments is equal to 5
if [ $# -ne 5 ]; then
    echo "Invalid number of arguments.."
    exit 1
fi

resourceGroupName=$1
templateFile=$2
frontDoorName=$3
backEndPoolName=$4
backendAddress=$5


# Print arguments
echo "In createFrontDoor.sh"
echo "Resource Group : " $resourceGroupName
echo "Template file : " $templateFile
echo "Front Door Name : " $frontDoorName
echo "Backend Pool Name : " $backEndPoolName
echo "Backend Address (Host Name) : " $backendAddress

# Create resource group and frontdoor
az deployment group create --resource-group $resourceGroupName --template-file $templateFile --parameters frontDoorName=$frontDoorName --parameters backEndPoolName=$backEndPoolName --parameters backendAddress=$backendAddress &
wait $!