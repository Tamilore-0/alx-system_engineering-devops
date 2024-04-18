# puppet code that sets nginx ULIMIT
exec { 'Fix-nginx-ulimit':
  command => '/bin/sed -i "s/^ULIMIT=\"-n 15\"/ULIMIT=\"-n 768\"/" /etc/default/nginx',
  onlyif  => '/bin/grep -q \'ULIMIT="-n 15"\' /etc/default/nginx',
  path    => '/bin/',
  before  => Exec['restart-nginx'],
}

exec { 'restart-nginx':
  command => '/usr/bin/sudo /usr/sbin/service nginx restart',
}
