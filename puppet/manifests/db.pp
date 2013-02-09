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
    require => Exec['apt-update'],
  }

}



# NGINX
# --------------------------

class nginx {
 
  package { "nginx":
    ensure => latest,
  }


}




# MySQL
# --------------------------

class mysql {

 
  package { "mysql-server":
    ensure => latest,
    require => Exec['apt-update'], 
  }

  service { "mysql":
    enable => true,
    ensure => running,
    require => Package["mysql-server"],
  }


   # file {
   #   'my.cnf':
   #       ensure => file,
   #       source => "puppet:///modules/mysql/my.cnf",
   #       path => '/etc/mysql/my.cnf',
   #       mode => 644,
   #       owner => root,
   #       group => root,
   #       notify => Service['mysql'],
   #       require => [Package["mysql-server"]]
   # }




 
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
include nginx
include mysql