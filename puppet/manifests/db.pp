# Basic Puppet Apache manifest


# PUPPET
# --------------------------

class groups {

  group { "puppet":
      ensure => present,
  }

}



# SYSTEM-UPDATE
# --------------------------


class system-update {


  $sysPackages = [ "build-essential" ]

  exec { 'apt-get update':
   command => '/usr/bin/apt-get update --fix-missing'
  }

  package { $sysPackages:
    ensure => "installed",

  }

}





# MySQL
# --------------------------

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
 
  #exec { "create-database":
  #  unless  => "/usr/bin/mysql -usite_development -psite_development site_development",
  #  command => "/usr/bin/mysql -uroot -proot -e \"create database site_development; grant all on site_development.* to site_dev@localhost identified by 'site_development';\"",
  #  require => Service["mysql"],
  #}


}


# --------------------------


include groups
include system-update
include mysql