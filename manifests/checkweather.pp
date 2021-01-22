## Manifest to deploy check-weather script

file { '/usr/local/bin/check-weather.sh':
  ensure   => present,
  source   => 'puppet:///modules/checkweather/check-weather.sh',
  mode     => '0755',
  owner    => 'root',
  group    => 'root',
}

file { '/usr/local/bin/backup-weather.sh':
  ensure   => present,
  source   => 'puppet:///modules/checkweather/backup-weather.sh',
  mode     => '0755',
  owner    => 'root',
  group    => 'root',
}

service { "check-weather":
  ensure  => running,
  start   => "/usr/local/bin/check-weather.sh start",
  stop    => "/usr/local/bin/check-weather.sh stop",
  status  => "/usr/local/bin/check-weather.sh status",
  pattern => "check-weather",
  provider  => base,
}

cron { "backup-weather":
  ensure  => present,
  command => "/usr/local/bin/backup-weather.sh",
  user    => "root",
  hour    => "22",
}
