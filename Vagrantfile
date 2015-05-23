# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "hashicorp/precise64"

  config.vm.network "private_network", ip: "192.168.100.12"
  config.vm.synced_folder ".", "/vagrant", type: "nfs"
  config.vm.network "forwarded_port", guest: 9292, host: 9292

  config.berkshelf.enabled = true

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "datamuncher"
  end

end
