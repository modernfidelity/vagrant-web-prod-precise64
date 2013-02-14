# Class: mysql
#
#   This class installs mysql client software.
#
# Parameters:
#   [*client_package_name*]  - The name of the mysql client package.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#


#class mysql (
#  $package_name   = $mysql::params::client_package_name,
#  $package_ensure = 'present'
#) inherits mysql::params {

#  package { 'mysql_client':
#    name    => $package_name,
#    ensure  => $package_ensure,
#  }

#}





class mysql {

  package {
    ["mysql-client", "mysql-server", "libmysqlclient-dev"]: 
      ensure => installed, 
      
  }

 
  service { "mysql":
    ensure => running,
    require => Package["mysql-server"],
  }
 
  exec { "set-mysql-password":
    unless  => "mysql -uroot -proot",
    path    => ["/bin", "/usr/bin"],
    command => "mysqladmin -uroot password root",
    require => Service["mysql"],
 
  }
 
  
  file {'my.cnf':
    owner   => root,
    group   => root,
    mode    => 0640,
    path    =>  '/etc/mysql/my.cnf',
    source  =>  '/vagrant/puppet/modules/mysql/templates/my.cnf',
  }



  #exec { "create-database":
  #  unless  => "/usr/bin/mysql -usite_development -psite_development site_development",
  #  command => "/usr/bin/mysql -uroot -proot -e \"create database site_development; grant all on site_development.* to site_dev@localhost identified by 'site_development';\"",
  #  require => Service["mysql"],
  #}


}