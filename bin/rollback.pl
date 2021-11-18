#!/usr/bin/perl

use strict;
use Data::Dumper;
use lib '.';

use config;

my $c = new config;
my $timeout = 5;

exit printf "Instance %s in $reg is done!\n", done if done;

system "sh bin/time-message.sh $env $reg $$ $timeout";

printf "\nRollback instance %s in $reg!\n", $env;


`az account set --subscription "Non-Production Subscription"`;

foreach my $rg (rg, mrg) {
  chdir "$root/bin";
  print "-- Remove $rg in the background\n";
  my $cmd = qq(sh rm-rg.sh $rg);
  system $cmd;
  if ($?) {
    print "Error: $?\n";
  } else {
    print " - Done!\n";
  }
}

print "-- Delete Hub Connections in the background\n";
my $cmd = sprintf "sh $root/bin/delete-vhub-vnet-connections.sh %s %s", rg, vnet;
print "$cmd\n";
system $cmd;

print "-- Delete IaC Hub Connections in the background\n";
my $cmd = sprintf "sh $root/bin/delete-vhub-vnet-connections.sh %s %s", mrg, mvnet;
print "$cmd\n";
system $cmd;


