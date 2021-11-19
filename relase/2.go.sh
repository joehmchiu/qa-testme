#!/bin/bash

env=${1:-"delme"}
reg=${2:-"uk"}
abs=$(realpath $0)
dir=$(dirname $abs)

az account set --subscription "Non-Production Subscription"
perl $dir/../2.create-rg-mgmt-vnet-snet.pl $env $reg
