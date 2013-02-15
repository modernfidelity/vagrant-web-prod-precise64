# Class: MYSQL 
#
#   This class installs mysql client software, configure password, creates a database and imports
#   a database.sql from the shared www folder if it exists...
#
#
# @TODO : 
#
#
#



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

  
  exec { "database-create":
    unless  => "/usr/bin/mysql -uroot -proot drupal",
    #command => "/usr/bin/mysql -uroot -proot -e \"create database ; grant all on my_website.* to vagrant@localhost identified by 'vagrant';\"",
    command => "/usr/bin/mysql -uroot -proot -e \"create database my_website; \"",
    require => Service["mysql"],
  }


  exec { "database-import":

    onlyif => '/usr/bin/test -f /vagrant/www/database.sql',
    command     => "/usr/bin/mysql -uroot -proot my_website < /vagrant/www/database.sql",
    logoutput   => true,

    
  }


  # RESOURCES RUN ORDER

  SERVICE['mysql'] -> EXEC['set-mysql-password'] -> EXEC['database-create'] -> EXEC['database-import']



}