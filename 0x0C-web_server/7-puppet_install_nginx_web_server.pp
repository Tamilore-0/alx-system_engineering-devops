# Ensure Nginx is installed and listening on port 80
# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Manage Nginx repository configuration
class { 'nginx':
  manage_repo => true,
}

# Define Nginx server block for example.com
nginx::resource::server { 'example.com':
  www_root    => '/var/www/html',
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
} ~> Service['nginx']


service { 'nginx':
  ensure  => 'running',
  enable  => true,
}

file { '/var/www/html/index.html':
  ensure  => present,
  content => "Hello World!\n",
  require => Package['nginx'],
}
 


