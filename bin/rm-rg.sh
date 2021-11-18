#!/bin/bash

rg=$1
az group delete -n $rg --no-wait --yes 
