#manifest to configure  server with Puppet

exec {'update':
  command  => 'sudo apt-get update',
  provider => shell,
} ->

package {'nginx':
  ensure => 'present',
} ->

# custom response header
exec {'header':
  command => 'hostname=$(hostname) ; echo "add_header X-Served-By \"$hostname\";" | sudo tee /etc/nginx/conf.d/custom_header.conf',
  provider => shell,
} ->

# start service
service { 'nginx':
  ensure  => running,
  enable  => true,
  provider => 'init',
}
