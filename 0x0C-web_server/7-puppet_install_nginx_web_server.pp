# Install and configure Nginx with a root page and /redirect_me 301 redirect

# Ensure nginx is installed
package { 'nginx':
  ensure => installed,
}

# Ensure nginx is running and enabled
service { 'nginx':
  ensure     => running,
  enable     => true,
  hasrestart => true,
}

# Ensure Hello World! is served at root
file { '/var/www/html/index.html':
  ensure  => file,
  content => "Hello World!\n",
  require => Package['nginx'],
}

# Add a redirect location to Nginx config
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Optional: Ensure the file has proper permissions
file { '/var/www/html':
  ensure => directory,
  owner  => 'www-data',
  group  => 'www-data',
  mode   => '0755',
}
