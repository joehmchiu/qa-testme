#!/bin/bash

env=${1:-"delme"}
reg=${2:-"uk"}
abs=$(realpath $0)
dir=$(dirname $abs)

cd $dir/../

az account set --subscription "Non-Production Subscription"
perl 4.hub-vnet-connection.pl $env $reg

