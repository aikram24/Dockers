Provision Enviorment With Chef Solo
Very simple vagrant file with chef solo  provisioning.
We will be installing apache2 using chef solo. So we don't have to manually install and link the /var/www to shared folder /vargrant.

We will be using simple ubuntu box image for this.

config.vm.box_url = "http://files.vagrantup.com/precise64.box"

/vagrant is share from your host machine. It will be there even you destroy the guest vagrant.
