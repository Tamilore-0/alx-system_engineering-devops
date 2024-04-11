file { '/var/www/html/wp-settings.php':
  ensure  => present,
  content => replace("require_once( ABSPATH . WPINC . '/class-wp-locale.phpp' );", "require_once( ABSPATH . WPINC . '/class-wp-locale.php' );"),
}
