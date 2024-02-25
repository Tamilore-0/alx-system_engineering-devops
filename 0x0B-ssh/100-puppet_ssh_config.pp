# Puppet code to change configuration to set identity
# file and not allow password authentication

file { '/etc/ssh/ssh_config':
  ensure  => 'present',
  content => "PasswordAuthentication no\nIdentityFile ~/.ssh/school\n",
}
