# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "hashicorp/precise64"

  config.vm.network "private_network", ip: "192.168.100.12"
  config.vm.synced_folder ".", "/vagrant", type: "nfs"
  config.vm.network "forwarded_port", guest: 4567, host: 4567

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "berkshelf/datamuncher/Berksfile"

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "berkshelf"
    chef.add_recipe "datamuncher"
  end

end
