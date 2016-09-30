include nginx



class nginx {
include nginx::install
include nginx::main
include nginx::services

Class['nginx::install'] -> Class['nginx::main'] -> Class['nginx::services']
}


### Installtion ###
class nginx::install{

notify { "Installing required packages ... ": }

exec { 'apt-get-update':
    command => '/usr/bin/apt-get update -y',
}

exec { 'apt-get-install-puppet':
    command => '/usr/bin/apt-get install puppet -y',
    require => Exec['apt-get-update']
}

$required_packages= ["nginx", "git"]
package { $required_packages:
   ensure => "latest",
   require => Exec['apt-get-update'],
}
}



### Main Stuff ####
class nginx::main {

$full_web_path = "/docroot"

file { $full_web_path:
   ensure => directory,
   owner   => 0,
   group   => 0,
}

exec { "git clone":
	command => "/vagrant/script/clone-check.sh",
	require => File[$full_web_path],
	}

file { "/etc/nginx/nginx.conf":
	 ensure => present,
	 owner => "root",
	 group => "root",
	 source=>"file:///vagrant/puppet/conf/nginx.conf",
	 require => [ File["/var/log/nginx/access.log"], File["/var/log/nginx/error.log"] ],
	 }
file { "/var/log/nginx/access.log":
         ensure => present,
	 owner => "www-data",
         group => "www-data",
}
file { "/var/log/nginx/error.log":
         ensure => present,
         owner => "www-data",
         group => "www-data",
}


}


### Services ###
class nginx::services {
notify { "Restarting nginx ....": }
service {"nginx":
	enable =>true,
	ensure =>running,
}
exec { "/etc/init.d/nginx restart" :
	command => "/etc/init.d/nginx restart",
	require => Service["nginx"],

}
}






