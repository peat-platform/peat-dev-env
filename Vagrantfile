# -*- mode: ruby -*-
# vi: set ft=ruby :



VAGRANTFILE_API_VERSION = "2"
PEAT_REPO_PATH         = "/Users/dmccarthy/work/openi/wp4/"
CPU_ALLOC               = 4
RAM_ALLOC               = 4096
CLIENT_IP_ADDRESS       = "192.168.33.10"



Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box     = "ubuntu/trusty64"
  # config.vm.box_url = "http://files.vagrantup.com/precise64.box"

end


Vagrant::VERSION >= "1.1.0" and Vagrant.configure("2") do |config|

    # Windows users shouldn't need to change this, since Vagrant will ignore the request for NFS synced folders on Windows
    config.vm.synced_folder PEAT_REPO_PATH, "/home/vagrant/repos", :nfs => false, :nfs_version => 3

    config.vm.network :private_network, ip: CLIENT_IP_ADDRESS

    config.ssh.forward_agent     = true

    config.ssh.forward_x11       = true

    config.vm.provider :virtualbox do |vb, override|
        override.vm.provision :shell, :path => "bootstrap.sh"

        # increase default VM RAM
        vb.customize ["modifyvm", :id, "--memory", RAM_ALLOC]
        vb.customize ["modifyvm", :id, "--cpus",   CPU_ALLOC   ]
    end

end
