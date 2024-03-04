#manifest to configure  server with Puppet

exec {'update':
  command  => 'sudo apt-get update',
  provider => shell,
} ->

package {'nginx':
  ensure => 'installed',
} ->

service { 'nginx':
  ensure  => running,
  enable  => true,
} ->

exec {'Hello':
  command  => 'echo "Hello World!" | sudo tee /var/www/html/index.html',
  provider => shell,
} -> 

# sets up redirection
exec {'sudo sed -i "s/listen 80 default_server;/listen 80 default_server;\\n\\tlocation \/redirect_me {\\n\\t\\treturn 301 https:\/\/github.com\/tami-cp0\/;\\n\\t}/" /etc/nginx/sites-available/default':
  provider => shell,
} ->

# SET custom response header
exec {'header':
  command => 'hostname=$(hostname) ; echo "add_header X-Served-By $hostname;" | sudo tee /etc/nginx/conf.d/custom_header.conf',
  provider => shell,
  notify => Service['nginx'],
}
