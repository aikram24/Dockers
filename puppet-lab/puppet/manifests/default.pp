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
$full_web_path = '/docroot'
file { $full_web_path:
   ensure => directory,
   owner   => 0,
   group   => 0,
}

exec { "git clone":
	#command => "/bin/ls -la $full_web_path/.git; if [ $? != 0 ] ; then  /usr/bin/git clone https://github.com/puppetlabs/exercise-webpage.git $full_web_path; else continue; fi",
	command => "/usr/bin/git clone https://github.com/puppetlabs/exercise-webpage.git $full_web_path",
	require => File[$full_web_path],
	}

file { "/etc/nginx/nginx.conf":
	 ensure => present,
	 owner => 0,
	 group => 0,
	 source=>"file:///vagrant/puppet/conf/nginx.conf"
	 }


}


### Services ###
class nginx::services {
notify { "Starting nginx ....": }
service {"nginx":
	enable =>true,
	ensure =>running,
}
}






