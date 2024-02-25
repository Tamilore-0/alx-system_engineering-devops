# Puppet code that that kills a process named killmenow.

exec { 'kill_my_process':
  command => 'pkill killmenow',
  path    => '/usr/bin',
}
