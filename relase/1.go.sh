#!/bin/bash

env=${1:-"delme"}
reg=${2:-"uk"}
abs=$(realpath $0)
dir=$(dirname $abs)

az account set --subscription "Non-Production Subscription"
perl $dir/../1.create-rg-vnet-snet.pl $env $reg

