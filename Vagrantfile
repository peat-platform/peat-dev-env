# -*- mode: ruby -*-
# vi: set ft=ruby :



VAGRANTFILE_API_VERSION = "2"
OPENI_REPO_PATH         = "/Users/dmccarthy/work/openi/tmp"
CPU_ALLOC               = 4
RAM_ALLOC               = 4096
CLIENT_IP_ADDRESS       = "192.168.33.10"


$script = <<SCRIPT

apt-get update -q

apt-get install -y git
apt-get install -qy wget curl
apt-get install -qy g++ curl libssl-dev apache2-utils
apt-get install -y make

#INSTALL node.js
cd /tmp ; wget http://www.nodejs.org/dist/v0.10.21/node-v0.10.21.tar.gz; tar -xzvf node-v0.10.21.tar.gz
cd /tmp/node-v0.10.21/ ; ./configure ; make ;  sudo make install
cd /tmp


#INSTALL ZMQ

apt-get install -y g++ uuid-dev binutils libtool autoconf automake
cd /tmp ; wget http://download.zeromq.org/zeromq-3.2.4.tar.gz ; tar -xzvf zeromq-3.2.4.tar.gz
cd /tmp/zeromq-3.2.4/ ; ./configure ; make ; sudo make install
ldconfig

cd /home/vagrant

# INSTALL SQLite3

apt-get install -y sqlite3
apt-get install -y libsqlite3-dev

# INSTALL Mongrel2

cd /tmp ; wget --no-check-certificate https://github.com/zedshaw/mongrel2/tarball/v1.8.0 ; tar -xzvf v1.8.0
cd /tmp/zedshaw-mongrel2-bc721eb/ ; ./configure ; make ; make install

# INSTALL Couchbase
cd /tmp ; wget http://packages.couchbase.com/releases/2.2.0/couchbase-server-enterprise_2.2.0_x86_64.deb
dpkg -i /tmp/couchbase-server-enterprise_2.2.0_x86_64.deb

#usermod -a -G vagrant vagrant
#
sudo mkdir -p /opt/openi/cloudlet_platform/logs/
sudo chown -R vagrant:vagrant /opt/openi/cloudlet_platform/

#Install build tools
sudo npm install -g grunt-cli

#Install CouchDB
sudo apt-get install couchdb -y

cat > /home/vagrant/.ssh/config <<DELIM
Host gitlab.openi-ict.eu
StrictHostKeyChecking no
DELIM

ssh -oStrictHostKeyChecking=no git@gitlab.openi-ict.eu

cd /home/vagrant/repos

git clone git@gitlab.openi-ict.eu:cloudlet_platform.git
git clone git@gitlab.openi-ict.eu:cloudlet_api.git
git clone git@gitlab.openi-ict.eu:object_api.git
git clone git@gitlab.openi-ict.eu:type_api.git
git clone git@gitlab.openi-ict.eu:m2nodehandler.git
git clone git@gitlab.openi-ict.eu:dao.git
git clone git@gitlab.openi-ict.eu:mongrel2.git
git clone git@gitlab.openi-ict.eu:dbc.git
git clone git@gitlab.openi-ict.eu:openi-cloudlet-utils.git
git clone git@gitlab.openi-ict.eu:openi-docker.git
git clone git@gitlab.openi-ict.eu:openi-logger.git
git clone git@gitlab.openi-ict.eu:openi-docker.git

sudo cp /vagrant/custom_hosts_file /etc/hosts
sudo cp /vagrant/custom_couchdb_config_file /etc/couchdb/default.ini

sudo sh /etc/init.d/networking restart
sudo service couchdb restart

tmp=`mktemp -q` && {
    apt-get install -q -y --no-upgrade linux-image-generic-lts-raring | \
    tee "$tmp"

    NUM_INST=`awk '$2 == "upgraded," && $4 == "newly" { print $3 }' "$tmp"`
    rm "$tmp"
}

SCRIPT


$all_script = <<VBOX_SCRIPT + $script

if [ ! -d /opt/VBoxGuestAdditions-4.3.6/ ]; then
    # Update remote package metadata.  'apt-get update' is idempotent.
    apt-get update -q
    
    # Kernel Headers and dkms are required to build the vbox guest kernel
    # modules.
    apt-get install -q -y linux-headers-generic-lts-raring dkms
    apt-get install build-essential linux-headers-`uname -r` dkms
    
    echo 'Downloading VBox Guest Additions...'
    wget -cq http://dlc.sun.com.edgesuite.net/virtualbox/4.3.6/VBoxGuestAdditions_4.3.6.iso
    echo "95648fcdb5d028e64145a2fe2f2f28c946d219da366389295a61fed296ca79f0  VBoxGuestAdditions_4.3.6.iso" | sha256sum --check || exit 1
    
    mount -o loop,ro /home/vagrant/VBoxGuestAdditions_4.3.6.iso /mnt
    /mnt/VBoxLinuxAdditions.run --nox11
    umount /mnt
    fi
VBOX_SCRIPT


Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box     = "presice64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  
 end

Vagrant::VERSION >= "1.1.0" and Vagrant.configure("2") do |config|
    
    config.vm.synced_folder OPENI_REPO_PATH, "/home/vagrant/repos", :nfs => true, :nfs_version => 3

    config.vm.network :private_network, ip: CLIENT_IP_ADDRESS

    config.ssh.forward_agent     = true
    
    config.vm.provider :virtualbox do |vb, override|
        override.vm.provision :shell, :inline => $all_script
        
        # increase default VM RAM
        vb.customize ["modifyvm", :id, "--memory", RAM_ALLOC]
        vb.customize ["modifyvm", :id, "--cpus",   CPU_ALLOC   ]
    end
end