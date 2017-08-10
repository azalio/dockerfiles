class { 'postgresql::globals':
  manage_package_repo => true,
  version             => '9.6',
}->

class { 'postgresql::server': }

postgresql::server::db { 'razor_prd':
  user     => 'razor',
  password => postgresql_password('razor', 'mypass'),
}
