execute "apt-get update"
package "apache2"
execute "rm -rf /var/www"
execute "ln -sf /vagrant /var/www"

end
