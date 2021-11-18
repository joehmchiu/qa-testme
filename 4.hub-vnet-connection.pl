#!/usr/bin/perl

use strict;
use Data::Dumper;
use lib '.';
use config;

my $c = new config;

my $cmd = sprintf "sh $root/bin/vhub-vnet-connections.sh %s %s", rg, vnet;
print "$cmd\n";
system $cmd;

