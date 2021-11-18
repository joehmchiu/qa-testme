#!/usr/bin/perl

use strict;
use Data::Dumper;
use lib '.';
use config;

my $c = new config(env => 'qa');
$c->init;

printf "Connect VHub %s -> %s\n", mrg, mvnet;

my $cmd = sprintf "sh $root/bin/vhub-vnet-connections.sh %s %s", mrg, mvnet;
print "$cmd\n";
system $cmd;

