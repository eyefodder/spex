# (c) 2014 Eyefodder, author: Paul Barnes-Hoggett
# This code is licensed under MIT license (see LICENSE.txt for details)
class spex::trust_local_traffic{


}
class spex::create_db_role {
  class { 'postgresql::server':
    encoding => 'UTF8',
    locale   => 'en_US',
  }
  postgresql::server::role { 'vagrant': superuser => true,}
}


class spex::postgres_setup{
    class { 'postgresql::globals':
    manage_package_repo => true,
    version             => '9.3',
  } ->
  class { 'postgresql::server':
    encoding => 'UTF8',
    locale   => 'en_US',
  }

  postgresql::server::pg_hba_rule{ 'trust_unix_all':
    type        => 'local',
    database    => 'all',
    user        => 'all',
    auth_method => 'trust',
    order       => '00001',
  }
  postgresql::server::pg_hba_rule{ 'trust_IPv4_all':
    type        => 'host',
    database    => 'all',
    user        => 'all',
    auth_method => 'trust',
    address     => '127.0.0.1/32',
    order       => '00002',
  }
  postgresql::server::pg_hba_rule{ 'trust_IPv6_all':
    type        => 'host',
    database    => 'all',
    user        => 'all',
    auth_method => 'trust',
    address     => '::1/128',
    order       => '00003',
  }

  postgresql::server::role { 'vagrant': superuser => true,}
  # include spex::trust_local_traffic
  # include spex::create_db_role
}
