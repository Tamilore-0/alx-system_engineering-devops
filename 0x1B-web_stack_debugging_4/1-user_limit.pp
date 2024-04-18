# puppet code to change user open file limit
exec { 'Fix-holberton-nofile-limits':
  command => 'sed -i "s/^holberton hard nofile 5/holberton hard nofile 100/; \
               s/^holberton soft nofile 4/holberton soft nofile 99/" \
               /etc/security/limits.conf',
  onlyif  => 'grep -q \'holberton hard nofile 5\' /etc/security/limits.conf && \
               grep -q \'holberton soft nofile 4\' /etc/security/limits.conf',
  path    => '/bin/',
}
