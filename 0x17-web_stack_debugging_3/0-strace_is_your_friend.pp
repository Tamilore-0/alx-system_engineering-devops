# puppet code that fixes typo
exec { 'Fix-wordpress':
  command => "/bin/grep -q \"require_once( ABSPATH . WPINC . '/class-wp-locale.phpp' );\" \
              /var/www/html/wp-settings.php && \
              sed -i \"s|require_once( ABSPATH . WPINC . '/class-wp-locale.phpp' );|\
              require_once( ABSPATH . WPINC . '/class-wp-locale.php' );|g\" \
              /var/www/html/wp-settings.php",
  onlyif  => "/bin/grep \"require_once( ABSPATH . WPINC . '/class-wp-locale.phpp' );\" /var/www/html/wp-settings.php",
}

