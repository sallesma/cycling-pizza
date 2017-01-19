# -*- mode: ruby -*-
# vi: set ft=ruby :

# There is a problem with some versions of virtualbox guest additions
# If vagrant up fails, use vagrant ssh and then sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions
# Then exit and vagrant provision

Vagrant.configure(2) do |config|
  config.vm.box = "phusion/ubuntu-14.04-amd64"

  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.synced_folder ".", "/home/vagrant/cycling-pizza", owner: "vagrant", group: "vagrant"

  config.vm.provision :shell, path: "vagrant_bootstrap.sh", privileged: false
end