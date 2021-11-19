#!/bin/bash

echo "RG status:"
# za-get-it rg-mgmt-nonprod-001; za-get-it rg-apps-nonprod-001; za-get-it rg-dbs-nonprod-001
# az group list | jq '.[] | {name: .name, status: .properties.provisioningState}' | grep -E '\-mgmt|\-dbs|\-apps'
# az group list | jq '.[] | select(.name | test("-delme|-qa|-uat|-test|-stage")) | {name: .name, status: .properties.provisioningState} | join (" => ")'
# az group list | jq '.[] | select(.name | test("-delme|-qa|-uat|-test|-stage|-prod")) | (.name + " => " + .properties.provisioningState)'
az group list | jq -r \
  '("Name\tStatus"),("----\t------"),(.[] | select(.name | test("-delme|-qa|-uat|-test|-stage|-prod")) | .name+"\t"+.properties.provisioningState)' | column -t



# echo 
# echo 
# echo "DNS Links status:"
# az network private-dns link vnet list -g rg-vpn-nonprod-001 -z qa.ohq.com.au | jq '.[] | {name: .name, status: .provisioningState}'
# 
# echo 
# echo 
# echo "DNS Zone status:"
# az network private-dns zone list -g rg-vpn-nonprod-001  | jq '.[] | {name: .name, status: .provisioningState}'

echo 
echo 
echo "VHub connection status:"
az account set --subscription "Networking"
# az network vhub connection list --vhub-name vhub-australiaeast-001 -g rg-net-vwan-001 | jq '.[] | select(.name | test("-delme|-qa|-uat|-test|-stage|-prod")) | {name: .name, status: .provisioningState}'
az network vhub connection list --vhub-name vhub-australiaeast-001 -g rg-net-vwan-001 | jq -r \
  '("Name\tStatus"),("----\t------"),(.[] | .name+"\t"+.provisioningState)' | column -t



#   '("Name\tStatus"),(.[] | select(.name | test("-delme|-qa|-uat|-test|-stage|-prod")) | .name+"\t"+.provisioningState)' | column -t
#   '("Name\tStatus"),("--------------------------------------\t------------"),(.[] | select(.name | test("-delme|-qa|-uat|-test|-stage|-prod")) | .name+"\t"+.provisioningState)' | column -t
#     jq -r '.[] | select(.name | test("-delme|-qa|-uat|-test|-stage|-prod")) | [.name, .provisioningState] | @tsv'
#     jq -r '.[] | select(.name | test("-delme|-qa|-uat|-test|-stage|-prod")) | ("{ " + .name + "\t\t => " + .provisioningState + " }")'
#     jq -r '.[] | select(.name | test("-delme|-qa|-uat|-test|-stage|-prod")) | [.name,.provisioningState] | join (" => ")'
az account set --subscription "Non-Production Subscription"
