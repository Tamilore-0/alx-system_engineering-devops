# Ensure Nginx is installed and listening on port 80
# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Manage Nginx repository configuration
class { 'nginx':
  manage_repo => true,
}

# Define Nginx server block for the default server
nginx::resource::server { 'default_server':
  listen_port => '80',
  server_name => '_',
  ensure      => present,
  require     => Package['nginx'],  # Ensure Nginx package is installed first
  locations   => {
    '/' => {  # Define location block for the root path
      ensure => present,
      # Use the 'location' parameter to define Nginx location blocks
      location => {
        'return' => '301',
        'value'  => 'https://github.com/tami-cp0',
      },
    },
  },
} ~> Service['nginx']  # Ensure Nginx service restarts after server configuration

service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => Package['nginx']
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => "Hello World!\n",
  require => [Package['nginx'], Service['nginx']],  # Require Nginx package and service
  notify  => Service['nginx'],
}
