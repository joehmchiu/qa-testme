#!/bin/bash

env=${1:-"delme"}
reg=${2:-"uk"}
abs=$(realpath $0)
dir=$(dirname $abs)

az account set --subscription "Non-Production Subscription"
cd $dir
perl 1.create-rg-vnet-snet.pl
perl 2.create-rg-mgmt-vnet-snet.pl
perl 3.private-dns-link.pl
perl 4.hub-vnet-connection.pl
perl 5.hub-mgmt-vnet-connection.pl
rm -rf /tmp/workspace
perl 6.create-vms-artifacts.pl

