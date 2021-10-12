#!/bin/bash

az graph query -q "Resources | project name, properties.customDomainVerificationId, type | where type == 'microsoft.web/sites'" > output.json &
wait $!

dnsRecordSetValue=$(/usr/bin/python printVerificationId.py $3 'output.json')
#wait $!

ResourceGroupName=$1
ZoneName=$2
appServiceName=$3

echo "In createDNSRecordSet.sh"
echo "ResourceGroupName : $ResourceGroupName"
echo "ZoneName : $ZoneName"
echo "appServiceName : $appServiceName"
echo "dnsRecordSetValue : $dnsRecordSetValue"

echo "Creating record set type : cname"
az network dns record-set cname set-record --resource-group $ResourceGroupName --zone-name $ZoneName --record-set-name $appServiceName --cname $ZoneName &
wait $!

echo "Creating record set type : txt"
az network dns record-set txt add-record --resource-group $ResourceGroupName --zone-name  $ZoneName --record-set-name 'asuid.'$appServiceName --value $dnsRecordSetValue &
wait $!

echo "Creating record set type : txt"
az network dns record-set txt add-record --resource-group $ResourceGroupName --zone-name  $ZoneName --record-set-name 'awverify.'$appServiceName --value $appServiceName'.azurewebsites.net' &
wait $!

#if [ -f output.json ]; then
#   rm output.json
#fi