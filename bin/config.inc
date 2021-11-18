
# l -> loc, r -> region, d -> dns, v => vnet, s => snet
$c = {
  au => { l => 'australiaeast', r => 'australiaeast', d => 'az.officehq.com.au', v => 10, },
  us => { l => 'global',        r => 'westus3',       d => '',                   v => 20, },
  uk => { l => 'uksouth',       r => 'uksouth',       d => '',                   v => 30, },
  loc => {
    uk => 'uksouth',
    au => 'australiaeast',
    us => 'global',
  },
  region => {
    uk => 'uksouth',
    au => 'australiaeast',
    us => 'westus3',
  },
  dns => {
    uk => '',
    au => 'az.officehq.com.au',
    us => '',
  },
  vnet => '10.%d.0.0/16',
  snet => '10.%d.%d.0/24',
  ssnet => {
    dev   => { app => '10.%d.%d.0/25', dbs => '10.%d.%d.128/25', iac => '10.%d.253.224/28', },
    prod  => { app => '10.%d.%d.0/25', dbs => '10.%d.%d.128/25', iac => '10.%d.253.224/28', },
    qa    => { app => '10.%d.%d.0/25', dbs => '10.%d.%d.128/25', iac => '10.%d.253.224/28', },
    stage => { app => '10.%d.%d.0/25', dbs => '10.%d.%d.128/25', iac => '10.%d.253.224/28', },
    test  => { app => '10.%d.%d.0/25', dbs => '10.%d.%d.128/25', iac => '10.%d.253.224/28', },
    uat   => { app => '10.%d.%d.0/25', dbs => '10.%d.%d.128/25', iac => '10.%d.253.224/28', },
    delme => { app => '10.%d.%d.0/25', dbs => '10.%d.%d.128/25', iac => '10.%d.253.224/28', },
  },
};

sub region {
  return $c->{$reg}->{r}
}
sub loc {
  return $c->{$reg}->{l}
}
sub vn2 { # 2nd vnet network number
  return $c->{$reg}->{v}
}

sub vnetcidr {
  sprintf $c->{vnet}, vn2;
}

sub snetcidr {
  sprintf $c->{snet}, vn2, sort keys %{$c->{ssnet}};
}

sub ssnetcidr {
  my $stype = shift;
  if ($stype !~ /iac/i) {
    sprintf $c->{ssnet}->{$env}->{$stype}, vn2, sort keys %{$c->{ssnet}};
  } else {
    sprintf $c->{ssnet}->{$env}->{$stype}, vn2;
  }
}

sub rg {
  sprintf "rg-$env-%s-%03d", region, $idx;
}

sub vnet {
  sprintf "vnet-%s-$env-%03d", region, $idx;
}

sub snet {
  sprintf "snet-%s-$env-%03d", region, shift;
}

# short subnet name
sub ssnet {
  sprintf "snet-%s-$env", region;
}

sub tag {
  sprintf "Infrastructure %s %s", uc $env, ucfirst region;
}

sub rgzone {
  sprintf "rg-net-%s-dns-%03d", region, $idx;
}

sub dlink {
  sprintf "lnk-vnet-%s-%s-%03d", region, $env, $idx;
}

sub cv {
  my $h = {};
  $h->{rg} = rg;
  $h->{vnet} = vnet;
  $h->{snet} = snet;
  $h->{vnet_cidr} = vnetcidr;
  $h->{snet_cidr} = snetcidr
  $h->{postfix} = $env;
  $h->{location} = loc;
  $h->{tag} = tag;
  $h->{instance_count} = $idx;
  return $h;
}

1;
